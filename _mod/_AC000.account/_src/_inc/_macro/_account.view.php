<?php

    /**
     * macro account view
     *
     *
     *
     * TODO documentare
     *
     */

    /**
     * configurazione della view
     * =========================
     * 
     * 
     * TODO documentare
     * TODO fare una tabella con tutte le chiavi possibili spiegate
     * 
     * 
     */

    // informazioni della vista
    $ct['view'] = array(
        'table' => 'account',
        'open' => array(
            'page' => 'account.form',
        ),
        'cols' => array(
            'id' => '#',
            '__label__' => 'account',
            'anagrafica' => 'anagrafica',
            'se_attivo' => 'attivo',
            'gruppi' 	=> 'gruppi',
        ),
        'class' => array(
            'id' => 'd-none d-md-table-cell',
            '__label__' => 'text-left',
            'anagrafica' => 'text-left',
            'se_attivo' => 'text-left',
            'gruppi' 	=> 'text-left'
        )
    );

    // gestione default
	require DIR_SRC_INC_MACRO . '_default/_default.view.php';

    // trasformazione icona attivo/inattivo
	foreach( $ct['view']['data'] as &$row ) {
		if( is_array( $row ) ) {
			if( $row['se_attivo'] == 1 ) { 
                $row['se_attivo'] = '<i class="fa fa-check"></i>';
            } else {
                $row['se_attivo'] = NULL;
            }
		}
	}
