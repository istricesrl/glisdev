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
    $ct['form']['table'] = 'prodotti';

    // tipologie di documenti
    $ct['etc']['select']['tipologie_prodotti'] = mysqlQuery(
        $cf['mysql']['connection'],
        'SELECT id, __label__ FROM tipologie_prodotti_view ORDER BY __label__ ASC'
    );

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';
