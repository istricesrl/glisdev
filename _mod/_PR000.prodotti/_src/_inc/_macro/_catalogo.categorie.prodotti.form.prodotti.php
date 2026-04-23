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
    $ct['form']['table'] = 'categorie_prodotti';


    // informazioni della vista
    $ct['view'] = array(
        'table' => 'prodotti_categorie',
        'open' => array(
            'page' => 'catalogo.prodotti.form',
            'table' => 'prodotti',
            'field' => 'id_prodotto'
        ),
        'cols' => array(
            'id' => '#',
            'id_categoria' => 'ID categoria',
            'id_prodotto' => 'ID prodotto',
            'prodotto' => 'prodotto',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            'id_categoria' => 'd-none',
            'id_prodotto' => 'd-none',
            'prodotto' => 'no-wrap text-start',
            NULL => 'no-wrap'
        ),
        'onclick' => array(
            NULL => 'event.stopPropagation();'
        ),
        '__restrict__' => array(
            'id_categoria' => array('EQ' => $_REQUEST['categorie_prodotti']['id'] ?? NULL)
        ),
        '__sort__' => array(
            'prodotto' => 'ASC'
        ),
    );

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.view.php';

    // macro di default
    require DIR_SRC_INC_MACRO . '_default/_default.form.php';
