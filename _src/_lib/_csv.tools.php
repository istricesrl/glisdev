<?php

    /**
     * libreria per la gestione dei dati in formato CSV
     * 
     * Questa libreria contiene funzioni utili per la gestione dei dati in formato CSV e aiuta a svolgere le operazioni
     * più comuni come lettura e scrittura dei file CSV, trasformazione dei dati da array o in array, eccetera.
     * 
     * introduzione
     * ============
     * Il formato CSV è uno dei formati più diffusi e comuni per la gestione dei dati tabellari. CSV sta per "Comma Separated
     * Values" e consiste in un file di testo in cui le righe rappresentano le righe di una tabella e i campi sono separati
     * da un carattere di separazione, di solito la virgola. I campi di testo sono delimitati dalle doppie virgolette.
     * 
     * Questa libreria è pensata per semplificare al massimo la gestione dei file CSV (lettura e scrittura) e la trasformazione
     * dei dati presenti in un file CSV in un array associativo e viceversa, ovvero le operazioni che vengono effettuata più
     * di frequente con questo tipo di formato.
     * 
     * la questione del separatore
     * ---------------------------
     * Anche se il nome del formato farebbe pensare che i campi siano sempre separati da virgole, questo in realtà nella pratica
     * non avviene di frequente, per vari motivi. Il separatore può essere di fatto qualsiasi carattere, anche se i più comuni
     * oltre ai classici virgola e punto e virgola tendono ad essere caratteri meno utilizzati comunemente nel testo, come il pipe,
     * il paragrafo, la tabulazione (in questo caso si parla più propriamente di TSV, "Tab Separated Values"), eccetera.
     * 
     * costanti
     * ========
     * Questa libreria non definisce costanti proprie.
     * 
     * funzioni
     * ========
     * Le funzioni di questa libreria sono divise in tre categorie principali, le funzioni di lettura, le funzioni di scrittura e le
     * funzioni di supporto. Per comprendere l'architettura della libreria, si tenga presente che essa manipola i dati sia in lettura
     * che in scrittura in diverse condizioni, che richiedono funzioni specifiche per essere gestite. Si consideri che i dati di
     * partenza per la conversione da CSV ad array associativo possono essere, in ordine di raffinazione:
     * 
     * - un file contenente dati in formato CSV
     * - un'unica stringa contenente tutte le righe in CSV
     * - un array di stringhe, ognuna rappresentante riga CSV
     * 
     * In tutti questi tre casi si assume che la prima riga contenga le intestazioni dei campi, che verranno usate come chiavi dell'array
     * associativo di destinazione; se così non fosse, è necessario passare alle funzioni di lettura un array con le chiavi da utilizzare
     * per la costruzione dell'array.
     * 
     * Viceversa in scrittura si parte sempre da un array (associativo o no), che può essere convertito in CSV in diverse modalità, in ordine
     * di raffinazione:
     * 
     * - un array di stringhe, ognuna rappresentante una riga CSV
     * - una stringa contenente tutte le righe in CSV
     * - un file contenente dati in formato CSV
     * 
     * Le chiavi della prima riga dell'array associativo vengono usate come intestazioni dei campi, e vengono scritte come prima riga; se
     * si desidera utilizzare intestazioni diverse è necessario passare alle funzioni di scrittura un array con le intestazioni da utilizzare.
     * Se si parte invece da un array non associativo, il primo elemento dell'array viene considerato di intestazione, e anche qui se si
     * desidera utilizzare intestazioni diverse è necessario passarle alle funzioni di scrittura.
     * 
     * È anche possibile richiedere alle funzioni di scrittura di non scrivere le intestazioni, in modo da ottenere un file CSV senza
     * intestazioni oppure semplicemente dati che possono essere accodati ad altri già intestati (ad esempio per aggiungere righe a un file)
     * 
     * Per dare uniformità al naming delle funzioni di questa libreria si è scelto di adottare la seguente convenzione:
     * 
     * - ci si riferisce all'array di array associativi semplicemente come "array"
     * - ci si riferisce all'array di array non associativi semplicemente come "matrix"
     * - ci si riferisce al singolo array non associativo come "vector"
     * - ci si riferisce all'array di stringhe CSV come "csvArray"
     * - ci si riferisce alla stringa contenente una riga in CSV come "csvRow"
     * - ci si riferisce alla stringa contenente tutte le righe in CSV come "csvString"
     * - ci si riferisce al file CSV come "csvFile"
     * 
     * È abbastanza intuitivo come le varie forme che possono assumere i dati siano in pratica progressive, dal file CSV all'array associativo
     * infatti abbiamo:
     * 
     * - csvFile -> csvString -> csvArray -> array
     * 
     * mentre invece per la scrittura abbiamo:
     * 
     * - array -> csvArray -> csvString -> csvFile
     * 
     * Ovviamente è possibile abbreviare i percorsi o partire già da dati che si trovano in uno stato più avanzato ma è importante capire la
     * struttura generale in modo da poterla utilizzare nel modo corretto.
     * 
     * funzioni di lettura
     * -------------------
     * Le funzioni di lettura permettono di leggere un file, una stringa o un array di stringhe CSV e di convertirli in un array associativo
     * o non associativo.
     * 
     * funzione                     | descrizione
     * -----------------------------|---------------------------------------------------------------
     * csvFile2array()              | legge un file CSV e restituisce un array di array associativi
     * csvString2array()            | legge una stringa CSV e restituisce un array di array associativi
     * csvArray2array()             | legge un array di stringhe CSV e restituisce un array di array associativi
     * csvFile2matrix()             | legge un file CSV e restituisce un array di array non associativi 
     * csvString2matrix()           | legge una stringa CSV e restituisce un array di array non associativi
     * csvArray2matrix()            | legge un array di stringhe CSV e restituisce un array di array non associativi
     * 
     * funzioni di scrittura
     * ---------------------
     * Le funzioni di scrittura permettono di scrivere un array associativo o non associativo in un array di stringhe CSV, in un'unica
     * stringa CSV o in un file CSV.
     * 
     * funzione                     | descrizione
     * -----------------------------|---------------------------------------------------------------
     * array2csvFile()              | scrive un array di array associativi in un file CSV
     * array2csvString()            | scrive un array di array associativi in una stringa CSV
     * array2csvArray()             | scrive un array di array associativi in un array di stringhe CSV                  
     * matrix2csvFile()             | scrive un array di array non associativi in un file CSV
     * matrix2csvString()           | scrive un array di array non associativi in una stringa CSV
     * matrix2csvArray()            | scrive un array di array non associativi in un array di stringhe CSV
     * 
     * funzioni di supporto
     * --------------------
     * Le funzioni di supporto sono funzioni di utilità che vengono utilizzate dalle altre funzioni della libreria per lavorare.
     * 
     * funzione                     | descrizione
     * -----------------------------|---------------------------------------------------------------
     * guessSeparator()             | individua il separatore di un file CSV
     * csvRow2array()               | converte una riga contenente una stringa CSV in un array associativo
     * csvRow2vector()              | converte una riga contenente una stringa CSV in un array non associativo
     * 
     * alias di funzioni inseriti per retrocompatibilità
     * -------------------------------------------------
     * Per garantire la retrocompatibilità con il codice già esistente, sono stati inseriti degli alias che puntano alle funzioni
     * aggiornate.
     * 
     * funzione                     | descrizione
     * -----------------------------|---------------------------------------------------------------
     * csv2array()                  | alias di csvArray2array()
     * array2csv()                  | alias di array2csvArray()
     * 
     * dipendenze
     * ==========
     * Questa libreria ha alcune dipendenze che devono essere soddisfatte per funzionare correttamente. In particolare
     * sono richieste le seguenti funzioni:
     * 
     * funzione                         | libreria di appartenenza
     * ---------------------------------|---------------------------------------------------------------
     * logger()                         | core
     * openFile()                       | filesystem.tools
     * clean_string()                   | string.tools
     * 
     * Inoltre per funzionare correttamente la libreria richiede che siano definite le seguenti costanti globali:
     * 
     * costante                 | valore    | descrizione
     * -------------------------|-----------|---------------------------------------------------------------
     * WRITE_FILE_OVERWRITE     | w+        | indica l'apertura del file in modalità sovrascrittura
     * WRITE_FILE_APPEND        | a+        | indica l'apertura del file in modalità append
     * 
     * 
     */

    // definizione delle costanti della libreria
    if( ! defined( 'FILE_WRITE_OVERWRITE' ) )   { define( 'FILE_WRITE_OVERWRITE'    , 'w+' ); }
    if( ! defined( 'FILE_WRITE_APPEND' ) )      { define( 'FILE_WRITE_APPEND'       , 'a+' ); }

    // funzioni richieste
    if( ! function_exists( 'logger' ) ) {
        die( 'la funzione core logger() non è definita, definirla per utilizzare la libreria' );
    }

    /**
     * FUNZIONI DI LETTURA
     */

    /**
     * legge un file CSV e restituisce un array di array associativi
     * 
     * Questa funzione legge un file CSV e restituisce un array di array associativi; se il separatore fornito è NULL o false,
     * la funzione utilizza indirettamente guessSeparator() per individuarlo autonomamente. La funzione legge il file come array
     * di stringhe CSV e poi utilizza csvArray2array() per convertirlo in un array associativo. La funzione assume che la prima
     * riga del file contenga le intestazioni dei campi, se non viene passato esplicitamente un array di intestazioni.
     * 
     */
#    function csvFile2array( $f, $s = NULL, $h = NULL, $c = "\"", $e = '\\' ) {
#
#    }

    /**
     * legge una stringa CSV e restituisce un array di array associativi
     * 
     */
    function csvString2array() {
    
    }

    /**
     * legge un array di stringhe CSV e restituisce un array di array associativi
     * 
     */
    function csvArray2array() {

    }

    /**
     * legge un file CSV e restituisce un array di array non associativi 
     * 
     */
    function csvFile2matrix() {

    }

    /**
     * legge una stringa CSV e restituisce un array di array non associativi
     * 
     */
    function csvString2matrix() {

    }

    /**
     * legge un array di stringhe CSV e restituisce un array di array non associativi
     * 
     */
    function csvArray2matrix() {

    }

    /**
     * FUNZIONI DI SCRITTURA
     */



    /**
     * FUNZIONI DI SUPPORTO
     */

    /**
     * individua il separatore di un file CSV
     * 
     * Questa funzione riceve in input una stringa e trova il carattere più abbondante fra quelli indicati, e lo
     * restituisce come output.
     * 
     * @param       string      $t      la stringa da analizzare
     * @param       array       $s      un array di caratteri da cercare
     * 
     * @return      string              il carattere più abbondante
     * 
     */
    function guessSeparator( $t, $s = array( ',', ';', '|', "\t" ) ) {

        $r = NULL;
        $m = 0;

        foreach( $s as $x ) {
            $c = substr_count( $t, $x );
            if( $c > $m ) {
                $m = $c;
                $r = $x;
            }
        }

        return $r;

    }

    /**
     * converte una riga contenente una stringa CSV in un array associativo
     * 
     * Questa funzione riceve in input una stringa contenente una riga in formato CSV e la converte in un array associativo,
     * utilizzando le intestazioni date; in caso di discrepanza fra il numero di intestazioni e il numero di campi, la funzione
     * restituisce comunque i campi che è stata in grado di associare, utilizzando guessN (con N progressivo) per le testate
     * mancanti, ma logga un errore. Questa funzione si appoggia a csvRow2matrix() per fare il parsing della stringa CSV.
     * 
     * @param       string      $t      la stringa da convertire
     * @param       array       $h      le intestazioni da utilizzare
     * @param       string      $s      il separatore da utilizzare
     * @param       string      $c      il carattere di delimitazione dei campi
     * @param       string      $e      il carattere di escape
     * 
     * @return      array               l'array associativo
     * 
     */
    function csvRow2array( $t, $h, $s = NULL, $c = "\"", $e = '\\' ) {

        if( $s == NULL ) {
            $s = guessSeparator( $t );
        }

        $t = csvRow2vector( $t, $s, $c, $e );

        // se le intestazioni sono meno dei campi, aggiungo le intestazioni mancanti come guessN...guessN+x
        if( count( $h ) < count( $t ) ) {
            $h = array_merge( $h, array_map( function( $x ) { return 'guess' . $x; }, range( 1, count( $t ) - count( $h ) ) ) );
            logger( 'intestazioni mancanti: ' . print_r( $h, true ) . ' per i dati: ' . print_r( $t, true ), 'csv', LOG_ERR );
        } elseif( count( $h ) > count( $t ) ) {
            $h = array_slice( $h, 0, count( $t ) );
            logger( 'intestazioni in eccesso: ' . print_r( $h, true ) . ' per i dati: ' . print_r( $t, true ), 'csv', LOG_ERR );
        }

        $t = array_combine( $h, $t );

        return $t;

    }

    /**
     * converte una riga contenente una stringa CSV in un array non associativo
     * 
     * Questa funzione riceve in input una stringa contenente una riga in formato CSV e la converte in un array non associativo; se
     * il separatore fornito è NULL o false, la funzione utilizza guessSeparator() per individuarlo autonomamente.
     * 
     * @param       string      $t      la stringa da convertire
     * @param       string      $s      il separatore da utilizzare
     * @param       string      $c      il carattere di delimitazione dei campi
     * @param       string      $e      il carattere di escape
     * 
     * @return      array               l'array non associativo
     * 
     */
    function csvRow2vector( $t, $s = NULL, $c = "\"", $e = '\\' ) {

        if( $s == NULL ) {
            $s = guessSeparator( $t );
        }

        $t = clean_string( $t );
        $t = str_getcsv( $t, $s, $c, $e );
        $t = array_map( 'trim', $t );

        return $t;

    }

    /**
     * ALIAS DI FUNZIONI INSERITI PER RETROCOMPATIBILITÀ
     */

    /**
     * legge un file CSV e restituisce un array associativo
     *
     *
     * TODO documentare
     *
     */
    function csvFile2array( $file, $s = ",", $c = "\"", $e = '\\' ) {

        // debug
        // die( $file );

        // leggo il contenuto grezzo del file
        $grezzo = readFromFile( $file );

        // debug
        // var_dump( $grezzo );
        // var_dump( $s );

        // auto rilevamento separatore
        if( $s == NULL ) {
            $vg = substr_count( $grezzo[0], ',' );            
            $pv = substr_count( $grezzo[0], ';' );
            $s = ( ( $vg > $pv ) ? ',' : ';' );
            logger( 'virgole: ' . $vg . ' punti e virgola: ' . $pv . ' vince: ' . $s, 'details/csv/' . basename( $file ) );
        }

        // debug
        // die( print_r( $grezzo, true ) );

        // log
        logger( 'grezzo (separatore "'.$s.'")' . PHP_EOL . print_r( $grezzo, true ), 'details/csv/' . basename( $file ) );

        // faccio il parsing CSV di ogni riga
        $lavorato = csv2array( $grezzo, $s, $c, $e );

        // debug
        logger( 'lavorato (separatore "'.$s.'")' . PHP_EOL . print_r( $lavorato, true ), 'details/csv/' . basename( $file ) );

        // restituisco l'array associativo
        return( $lavorato );

    }

    /**
     * converte un array di stringhe CSV in un array associativo
     * 
     * prende in input un array di stringhe CSV e restituisce un array di array
     * associativi usando la prima riga per le intestazioni; la riga delle intestazioni
     * viene eliminata e non viene restituita fra i dati; le righe CSV devono avere
     * i campi separati da virgola, e tutti i campi di testo delimitati dalle doppie
     * virgolette
     * 
     * 
     * TODO documentare
     *
     */
    function csv2array( $data, $s = ",", $c = "\"", $e = '\\' ) {

        // logger( 'dati pre ' . print_r( $data, true ), 'details/csv/csv2array' );

        $result = array();

        $head = clean_string( $data[0] );
        $head = str_getcsv( $head, $s, $c, $e );
        $head = array_map( 'trim', $head );

        foreach( $data as &$row ) {
            logger( 'riga: ' . $row, 'details/csv/csv2array' );
            $row = clean_string( $row );
            logger( 'riga dopo clean_string: ' . $row, 'details/csv/csv2array' );
            $row = str_getcsv( $row, $s, $c, $e );
            logger( 'riga dopo str_getcsv: ' . print_r( $row, true ), 'details/csv/csv2array' );
            $row = array_map( 'trim', $row );
            logger( 'riga dopo map di trim: ' . print_r( $row, true ), 'details/csv/csv2array' );
            if( count( $head ) == count( $row ) ) {
                $rowCombined = array_combine( $head, $row );
                $result[] = $rowCombined;
                logger( 'riga con intestazioni: ' . print_r( $rowCombined, true ), 'details/csv/csv2array' );
            } else {
                logger( 'errore nel numero delle colonne (' . count( $head ) . '/' . count( $row ) . ') ' . print_r( $head, true ) . print_r( $row, true ), 'csv', LOG_ERR );
                logger( 'errore nel numero delle colonne (' . count( $head ) . '/' . count( $row ) . ') ' . print_r( $head, true ) . print_r( $row, true ), 'details/csv/csv2array' );
            }
        }

        logger( 'dati post ' . print_r( $result, true ), 'details/csv/csv2array' );

        array_shift( $result );

        // logger( 'dati finally ' . print_r( $result, true ), 'csv' );
        // print_r( $result );

        return $result;

    }

    /**
     * converte una matrice in un CSV, considerando la prima riga come intestazione
     * 
     * 
     * TODO servirebbe una versione con un parametro solo $data che ritorna la stringa CSV
     * TODO documentare
     *
     * function array2csv( $data, $file ) {
     * $h = openFile( $file );
     * fputcsv( $h, array_keys( $data[0] ) );
     * foreach( $data as $row ) {
     * fputcsv( $h, $row );
     * }
     * }
     * 
     * 
     * TODO svincolare da openFile
     * 
     */
    function array2csvFile( $data, $file, $mode = FILE_WRITE_OVERWRITE, $s = ",", $c = "\"", $e = '\\' ) {

        $h = openFile( $file, $mode );
    
        // $h = openFile( $file );
        if( getFileSize( $file ) == 0 ) {
            fputcsv( $h, array_keys( $data[0] ), $s, $c, $e );
        } 
    
        foreach( $data as $row ) {
            fputcsv( $h, $row, $s, $c, $e );
        }
    
    }

    /**
     * trasforma un array associativo in un array di stringhe CSV
     *
     * TODO documentare
     *
     */
    function array2csv( $data, $s = ",", $c = "\"", $e = '\\' ) {

        $csv = array();

        array_unshift( $data, array_keys( $data[0] ) );

        $h = fopen('php://memory', 'r+');

        foreach( $data as $row ) {
            fputcsv( $h, $row, $s, $c, $e );
        }

        rewind($h);

        while( $buf = fgets( $h ) ) {
            $csv[] = $buf;
        }

        fclose( $h );

        return $csv;

    }

    /**
     *
     * TODO documentare
     *
     */
    function array2csvString( $data, $s = ",", $c = "\"", $e = '\\' ) {

        $csv = array2csv( $data, $s, $c, $e );
        return implode( '', $csv );

    }
