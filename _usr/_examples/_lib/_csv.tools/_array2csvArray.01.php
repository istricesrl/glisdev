<?php

    /**
     * file di esempio per la funzione openFile()
     * 
     * 
     * 
     */

    // inclusione del framework
    require '../../../../_src/_config.php';

    // debug
     error_reporting( E_ALL );
     ini_set( 'display_errors', TRUE );

    // dati
    $d = array(
        array( 'col1' => 'val1', 'col2' => 'val2', 'col3' => 'val3' )
    );

    // debug
    var_dump( $d );

    // leggo l'array di stringhe CSV in un array di array associativi
    $a = array2csvArray( $d );

    // output
    var_dump( $a );
    