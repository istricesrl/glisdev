<?php

    /**
     * file di esempio per la funzione string2utf8()
     * 
     *
     * 
     */

    // inclusione del framework
    require '../../../../_src/_config.php';

    // stringa di test
    $s = mb_convert_encoding( 'TEST', 'ISO-8859-1' );
    var_dump( mb_detect_encoding( $s ) );

    // test della lingua del browser
    var_dump( string2utf8( $s ) );
    var_dump( mb_detect_encoding( $s ) );
