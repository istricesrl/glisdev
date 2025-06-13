<?php

    /**
     * file di esempio per la funzione openFile()
     * 
     * 
     * 
     */

    // inclusione del framework
    require '../../../../_src/_config.php';

    // ...
    $k = 'TEST';

    // ...
    $s = 'TEST CONTENT';

    // ...
    var_dump( encryptString( $s, $k ) );
