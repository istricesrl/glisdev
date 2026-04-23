<?php

    /**
     * macro form anagrafica
     *
     *
     * TODO documentare
     *
     */

    /**
     * configurazione del form
     * =======================
     * 
     * 
     * 
     */

    // tabella gestita
    $ct['form'] = array(
        'table' => 'tipologie_anagrafica',
    );

    /**
     * dati della view
     * ===============
     * 
     * 
     * 
     * 
     * 
     */

    // informazioni della vista
    $ct['view'] = array(
        'table' => 'anagrafica',
        'open' => array(
            'page' => 'anagrafica.form',
            'table' => 'anagrafica',
            'field' => 'id'
        ),
        'cols' => array(
            'id' => '#',
            '__label__' => 'anagrafica',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            '__label__' => 'no-wrap text-start',
            NULL => 'no-wrap'
        ),
        'onclick' => array(
            NULL => 'event.stopPropagation();'
        ),
        '__restrict__' => array(
            'id_tipologia' => array( 'EQ' => $_REQUEST['tipologie_anagrafica']['id'] ?? NULL )
        ),
        '__sort__' => array(
            '__label__' => 'ASC'
        ),
    );

    /**
     * macro di default
     * ================
     * 
     * 
     * 
     * 
     */

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.view.php';

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';

    /**
     * debug del form
     * ==============
     * 
     * 
     * 
     */

    // debug
    // print_r( $_REQUEST );
