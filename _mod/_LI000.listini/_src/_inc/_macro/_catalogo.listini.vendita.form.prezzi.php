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
    $ct['form']['table'] = 'listini';

    // informazioni della vista
    $ct['view'] = array(
        'table' => 'prezzi',
        'open' => array(
            'page' => 'catalogo.archivio.prezzi.form',
            'table' => 'prezzi',
            'preset' => array(
                'field' => 'id_listino',
            )
        ),
        'insert' => array(
            'page' => 'catalogo.archivio.prezzi.form',
        ),
        'cols' => array(
            'id' => '#',
            'reparto' => 'reparto',
            'prodotto' => 'prodotto',
            'articolo' => 'articolo',
            'prefisso' => 'prefisso',
            'prezzo' => 'prezzo',
            'suffisso' => 'suffisso',
            'iva' => 'iva',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            'reparto' => 'no-wrap text-start',
            'prodotto' => 'no-wrap text-start',
            'articolo' => 'no-wrap text-start',
            'prefisso' => 'no-wrap text-start',
            'prezzo' => 'no-wrap text-start',
            'suffisso' => 'no-wrap text-start',
            'iva' => 'no-wrap text-start',
            NULL => 'no-wrap'
        ),
        'onclick' => array(
            NULL => 'event.stopPropagation();'
        ),
        '__restrict__' => array(
            'id_listino' => array( 'EQ' => $_REQUEST['listini']['id'] ?? NULL )
        ),
        '__sort__' => array(
            'prodotto' => 'ASC'
        ),
    );

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.view.php';

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';

