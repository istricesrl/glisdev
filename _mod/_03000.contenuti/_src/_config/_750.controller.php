<?php

    /**
     * 
     * 
     * 
     * TODO documentare
     * 
     */

    // debug
    // die( print_r( $_REQUEST, true ) );
    // die( print_r( $_REQUEST['__templates__'], true ) );
    // die( print_r( $_REQUEST['__template_files__'], true ) );

    if( isset( $_REQUEST['__delete__'] ) && $_REQUEST['__delete__'] == 1 ) {

        // nome del file custom
        $custom = path2custom(
           DIR_SRC_TPL.
            '_' . $_REQUEST['__templates__']['id'] . '/' .
            ( ( isset( $_REQUEST['__template_files__']['folder'] ) && ! empty( $_REQUEST['__template_files__']['folder'] ) ) ? trim( $_REQUEST['__template_files__']['folder'], './' ) . '/' : NULL ) .
            $_REQUEST['__template_files__']['id']
        );

        $e = deleteFile( $custom );

        // var_dump( $e );
        // die( 'devo cancellare il file: ' . $custom );

    } elseif( isset( $_REQUEST['__templates__']['id'] ) && ! empty( $_REQUEST['__templates__']['id'] ) ) {

        // se è specificato un file per il template
        if( isset( $_REQUEST['__template_files__']['id'] ) && ! empty( $_REQUEST['__template_files__']['id'] ) ) {

            // ...
            if( isset( $_REQUEST['__template_files__']['folder'] ) && ! empty( $_REQUEST['__template_files__']['folder'] ) ) {
                $_REQUEST['__template_files__']['folder'] = trim( $_REQUEST['__template_files__']['folder'], './' );
            }

            // se è specificato un modulo per il template
            if( isset( $_REQUEST['__template_files__']['modulo'] ) && ! empty( $_REQUEST['__template_files__']['modulo'] ) ) {
                $base = DIR_MOD . 
                    '_' . $_REQUEST['__template_files__']['modulo'] . 
                    '/_src/_tpl/_' . $_REQUEST['__templates__']['id'] . '/' . 
                    ( ( isset( $_REQUEST['__template_files__']['folder'] ) ) ? $_REQUEST['__template_files__']['folder'] : NULL ) .
                    '/' . $_REQUEST['__template_files__']['id'];
            } else {
                $base = '_src/_tpl/' . 
                    '_' . $_REQUEST['__templates__']['id'] . '/' . 
                    ( ( isset( $_REQUEST['__template_files__']['folder'] ) ) ? $_REQUEST['__template_files__']['folder'] : NULL ) .
                    '/' . $_REQUEST['__template_files__']['id'];
            }

            // debug
            // var_dump( $base );
            // var_dump( absolutePath( $base ) );

            // ...
            $base = str_replace( '//', '/', $base );

            // ...
            // if( realpath( $base ) !== $base ) {
            if( trim( absolutePath( $base ), '/' ) !== trim( $base , '/' ) ) {
                die( trim( absolutePath( $base ), '/' ) . ' !== ' . trim( $base , '/' ) );
            }

            // nome del file custom
            $custom = path2custom( $base );

            // debug
            // var_dump( $_REQUEST['__template_files__']['contenuto'] );
            // var_dump( $custom );
            // var_dump( file_exists( $custom ) );
            // die( 'custom: ' . $custom );

            // controllo cartella
            checkFolder( dirname($custom) );

            // scrittura
            if( isset( $_REQUEST['__template_files__']['contenuto'] ) && ! empty( trim( $_REQUEST['__template_files__']['contenuto'] ) ) ) {

                // debug
                // die( 'sul file: ' . $custom . ' scrivo: ' . $_REQUEST['__template_files__']['contenuto'] );

                // ...
                writeToFile( $_REQUEST['__template_files__']['contenuto'], $custom );

            } elseif( ! file_exists( getFullPath( $custom ) ) && file_exists( getFullPath( $base ) ) ) {

                // debug
                // die( 'creazione nuovo file da standard' );
                // die( $custom );

                // ...
                $standard = readFromFile( $base );

                // ...
                writeToFile( $standard, $custom );

            } elseif( ! file_exists( getFullPath( $custom ) ) ) {

                // debug
                // die( 'creazione nuovo file vuoto' );
                // die( $custom );

                // ...
                writeToFile( PHP_EOL, $custom );

            }

            $ct['etc']['reading']['custom'] = '';
            $ct['etc']['reading']['base'] = '';
            $ct['etc']['fileread']['custom'] = '';
            $ct['etc']['fileread']['base'] = '';

            // cerco il contenuto custom e se non esiste prendo lo standard
            if( file_exists( getFullPath( $custom ) ) ) {

                // debug
                // die( $custom );
                // die( 'leggo dal file: ' . $custom );
                $ct['etc']['reading']['custom'] = readFromFile( $custom, FILE_READ_AS_STRING );
                $ct['etc']['fileread']['custom'] = $custom;

            }

            if( file_exists( getFullPath( $base ) ) ) {

                // die( $base );
                // die( 'leggo dal file: ' . $base . ' perché ' . $custom . ' non esiste' );
                $ct['etc']['reading']['base'] = readFromFile( $base, FILE_READ_AS_STRING );
                $ct['etc']['fileread']['base'] = $base;

            }

            if( empty( trim( $ct['etc']['reading']['custom'] ) ) ) {
                $ct['etc']['reading'] = $ct['etc']['reading']['base'];
                $ct['etc']['fileread'] = $ct['etc']['fileread']['base'];
            } else {
                $ct['etc']['reading'] = $ct['etc']['reading']['custom'];
                $ct['etc']['fileread'] = $ct['etc']['fileread']['custom'];
            }

            $_REQUEST['__template_files__']['contenuto'] = $ct['etc']['reading'];

        }

        // debug
        // die( 'ok' );

    }

    // debug
    // die( 'ok' );
