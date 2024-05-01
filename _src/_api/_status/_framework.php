<?php

    /**
     * visualizzatore dello stato di funzionamento del framework
     * 
     * 
     * TODO implementare
     * TODO documentare
     * 
     */

    // inclusione del framework
    require '../../_config.php';

    // header
	header( 'Content-type: text/plain' );

    // output
	echo 'STATUS DEL FRAMEWORK' . PHP_EOL . PHP_EOL;

    // versione di PHP
	echo '[INFO] versione di PHP trovata: ' . PHP_VERSION . PHP_EOL;

    // release del framework
	if( version_compare( RELEASE_CURRENT, RELEASE_LATEST ) == 0 ) {
	    echo '[ OK ] GlisWeb aggiornato alla release stable (' . RELEASE_CURRENT . ')' . PHP_EOL;
	} elseif( version_compare( RELEASE_CURRENT, RELEASE_LATEST ) == -1 ) {
	    echo '[WARN] stai usando una release obsoleta di GlisWeb (' . RELEASE_CURRENT . ') rispetto alla stable ' . RELEASE_LATEST . PHP_EOL;
	} else {
	    echo '[INFO] stai usando una release di sviluppo di GlisWeb (' . RELEASE_CURRENT . ') superiore alla stable ' . RELEASE_LATEST . PHP_EOL;
	}

    // versione del framework
	if( VERSION_CURRENT == VERSION_LATEST ) {
	    echo '[ OK ] GlisWeb aggiornato (' . VERSION_CURRENT . ')' . PHP_EOL;
	} elseif( VERSION_CURRENT < VERSION_LATEST ) {
	    echo '[WARN] stai usando una versione obsoleta di GlisWeb (' . VERSION_CURRENT . ') rispetto a ' . VERSION_LATEST . PHP_EOL;
	} else {
	    echo '[INFO] stai usando una versione di sviluppo di GlisWeb (' . VERSION_CURRENT . ') superiore a ' . VERSION_LATEST . PHP_EOL;
	}

