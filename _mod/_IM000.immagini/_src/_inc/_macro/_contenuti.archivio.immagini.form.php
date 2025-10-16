<?php

    /**
     * 
     * 
     * 
     * 
     * 
     * TODO documentare
     * 
     * 
     */

    // tabella gestita
    $ct['form']['table'] = 'immagini';

    // tendina ruolo immagini
	$ct['etc']['select']['ruoli_immagini'] = mysqlCachedIndexedQuery(
	    $cf['memcache']['index'],
	    $cf['memcache']['connection'],
	    $cf['mysql']['connection'],
	    'SELECT id, __label__ FROM ruoli_immagini_view WHERE se_anagrafica = 1'
	);

	$ct['etc']['select']['orientamenti'] = array( 
	    array( 'id' => NULL, '__label__' => 'automatico' ),
	    array( 'id' => 'L', '__label__' => 'landscape' ),
	    array( 'id' => 'P', '__label__' => 'portrait' ),
	);

    // tendina lingue
	$ct['etc']['select']['lingue'] = $cf['localization']['languages'];

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';

