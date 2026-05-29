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
            '__label__' => 'articolo',
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
            'id_listino' => array( 'EQ' => $_REQUEST['listini']['id'] ?? NULL )
        ),
        '__sort__' => array(
            '__label__' => 'ASC'
        ),
    );

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.view.php';

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';

