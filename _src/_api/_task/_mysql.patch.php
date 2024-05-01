<?php

    /**
     * applica le patch al database
     * 
     * questo task applica le patch al database; in fase di installazione questo significa creare
     * l'intero database da zero, poi durante il funzionamento normale del framework significa invece
     * applicare le patch rilasciate con le varie versioni per tenere il database allineato al codice
     * PHP del framework
     *
     * introduzione
     * ============
     * 
     * 
     * 
     *
     * TODO documentare
     *
     *
     */

    // inclusione del framework
    if( ! defined( 'CRON_RUNNING' ) ) {
        require '../../_config.php';
    }

    // inizializzo l'array del risultato
    $status = array();

    // data e ora di inizio del lavoro
    $status['start'] = date( 'Y-m-d H:i:s' );

    /**
     * codice principale di applicazione delle patch
     */

    // verifico la connessione
    if( ! empty( $cf['mysql']['connection'] ) ) {

        // ...
        header( 'Content-type: text/plain' );

        // creo la tabella di patch se non esiste
        mysqlQuery(
            $cf['mysql']['connection'],
            'CREATE TABLE IF NOT EXISTS `__patch__` ('.
            '    `id` char(12) NOT NULL PRIMARY KEY,'.
            '    `patch` text COLLATE utf8_unicode_ci,'.
            '    `timestamp_esecuzione` int(11) DEFAULT NULL,'.
            '    `token` char(128) DEFAULT NULL,'.
            '    `note_esecuzione` text'.
            ') ENGINE=InnoDB DEFAULT CHARSET=utf8;'
        );

        // debug
        // die( 'creazione della tabella di patch' );

        // cerco l'ultima patch eseguita
        $patchLevel = mysqlSelectValue(
            $cf['mysql']['connection'],
            'SELECT id AS patch_level FROM __patch__ ORDER BY id DESC LIMIT 1'
        );

        // patch level di default
        if( empty( $patchLevel ) ) {
            $patchLevel = '000000000000';
        }

        // cerco i patch file
        $pFiles = getFilteredFileList( DIR_USR_DATABASE_PATCH, '_*.*.sql', false, 'glob2custom' );

        // ordino i patch file per patch level
        sort( $pFiles );

        // debug
        // echo 'percorso di ricerca: ' . glob2custom( DIR_USR_DATABASE_PATCH . '_*.*.sql' ) . PHP_EOL;
        // echo 'patch level: ' . $patchLevel . PHP_EOL;
        // die( print_r( $pFiles, true ) );

        // processo un patch file alla volta
        foreach( $pFiles as $pFile ) {

            // ricavo il livello di patch del file dal nome
            // $pFilePatchLevel = substr( basename( $pFile ), 1, 12 );
            $pFilePatchLevel = substr( str_replace( '_', '', basename( $pFile ) ), 0, 12 );

            // debug
            // echo 'patch level del file ' . $pFilePatchLevel . PHP_EOL;
            // echo 'patch level del database ' . $patchLevel . PHP_EOL;
            // die( 'elaborazione file' );

            // se il livello di patch del file è maggiore di quello del database...
            if( $pFilePatchLevel > $patchLevel ) {

                // log
                logger( 'elaborazione file patch -> ' . $pFile, 'mysql', LOG_NOTICE );

                // debug
                // echo 'prelevo le patch dal file ' . $pFilePatchLevel . PHP_EOL;

                // leggo il file in un array (una riga per elemento)
                $rows = readFromFile( $pFile );

                // debug
                // echo 'righe trovate nel file ' . $pFile . ' -> ' . count( $rows ) . PHP_EOL;

                // id della patch
                $pId = '';

                // patch corrente
                $pQuery = '';
                $pComments = '';

                // processo le righe una alla volta
                foreach( $rows as $row ) {

                    // se la riga inizia con il marcatore, allora ho trovato una patch
                    if( substr( trim( $row ), 0, 4 ) == '-- |' ) {

                        // se la query che sto ricavando non è vuota...
                        if( ! empty( trim( $pQuery ) ) ) {

                            // debug
                            // echo 'eseguo la patch ' . $pId . PHP_EOL;

                            // se l'ID della patch che sto lavorando è maggiore del patch level del database
                            if( $pId > $patchLevel ) {

                                // log
                                logger( 'elaborazione patch -> ' . $$pId, 'mysql', LOG_NOTICE );

                                // eseguo la patch corrente
                                $pEx = mysqlQuery(
                                    $cf['mysql']['connection'],
                                    $pQuery
                                );

                                // debug
                                // echo 'scrivo la patch ' . $pId . PHP_EOL;

                                // risultato dell'esecuzione della patch
                                $pStatus = mysqli_errno( $cf['mysql']['connection'] ) . ' ' . mysqli_error( $cf['mysql']['connection'] );

                                // debug
                                if( ! empty( mysqli_errno( $cf['mysql']['connection'] ) ) ) {
                                    echo $pQuery . PHP_EOL;
                                    echo $pStatus . PHP_EOL;
                                    die( 'errore nella patch ' . $pQuery );
                                } else {
                                    echo 'patch ' . $pId . ' applicata correttamente' . PHP_EOL;
                                }

                                // registro l'esecuzione della patch nella tabella __patch__
                                $rEx = mysqlInsertRow(
                                    $cf['mysql']['connection'],
                                    array(
                                        'id' => $pId,
                                        'patch' => trim( $pQuery ),
                                        'timestamp_esecuzione' => ( ( empty( $pEx ) ) ? NULL : time() ),
                                        'note_esecuzione' => ( ( empty( mysqli_errno( $cf['mysql']['connection'] ) ) ) ? 'OK' : $pStatus )
                                    ),
                                    '__patch__',
                                    false
                                );

                                // risultato dell'esecuzione della patch
                                $pStatus = mysqli_errno( $cf['mysql']['connection'] ) . ' ' . mysqli_error( $cf['mysql']['connection'] );

                                // debug
                                if( ! empty( mysqli_errno( $cf['mysql']['connection'] ) ) ) {
                                    die( 'errore nella scrittura di ' . $pId . ' sulla tabella delle patch' );
                                }

                                // aggiorno il patch level al livello (ID) della patch che ho appena inserito
                                $patchLevel = $pId;

                            } else {

                                // debug
                                echo 'patch ' . $pId . ' obsoleta rispetto a ' . $patchLevel. PHP_EOL;
                                
                            }

                        } else {

                            // debug
                            if( empty( $pComments ) ) {
                                echo 'NON eseguo la patch ' . $pId . ' in quanto è vuota' . PHP_EOL;
                            }
                            
                        }

                        // leggo l'ID della patch
                        $pId = substr( $row, 5, 12 );

                        // se l'ID della patch è '------------' allora lo imposto alla data corrente
                        if( $pId == '------------' ) { $pId = date( 'YmdHis' ); }

                        // svuoto la query per ricominciare ad aggiungere righe
                        $pQuery = '';
                        $pComments = '';
                
                        // echo 'inizio la lettura della patch ' . $pId . PHP_EOL;
                        
                    } elseif( substr( trim( $row ), 0, 2 ) == '--' ) {

                        // aggiungo la riga corrente alla patch che sto leggendo
                        $pComments .= $row;

                    } elseif( substr( trim( $row ), 0, 2 ) !== '--' ) {

                        // aggiungo la riga corrente alla patch che sto leggendo
                        $pQuery .= $row . PHP_EOL;

                    }

                }

            }

        }

        // ...
        die( 'fine applicazione patch database' );

    } else {

        // ...
        die( 'connessione al database non disponibile' );

    }

    // output
    if( ! defined( 'CRON_RUNNING' ) ) {
        buildJson( $status );
    }
