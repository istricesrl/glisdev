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
            'prodotto' => 'prezzo',
            'articolo' => 'articolo',
            'prefisso' => 'prefisso',
            'prezzo' => 'prezzo',
            'suffisso' => 'suffisso',
            'iva' => 'iva',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            'prodotto' => 'd-none',
            'articolo' => 'd-none',
            'prefisso' => 'd-none',
            'prezzo' => 'd-none',
            'suffisso' => 'd-none',
            'iva' => 'd-none',
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

