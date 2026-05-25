<?php

    /**
     * macro anagrafica view
     * 
     * 
     * 
     * 
     * 
     * TODO documentare
     * 
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
        'table' => 'prezzi',
        'open' => array(
            'page' => 'catalogo.archivio.prezzi.form',
            'table' => 'prezzi'
        ),
        'cols' => array(
            'id' => '#',
            'listino' => 'listino',
            'prodotto' => 'prodotto',
            'articolo' => 'articolo',
            'qta_min' => 'q.tà min',
            'qta_max' => 'q.tà max',
            'prefisso' => 'prefisso',
            'prezzo' => 'prezzo',
            'suffisso' => 'suffisso',
            'sconto_articoli' => '% su articoli',
            'iva' => 'iva',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            'listino' => 'd-none',
            'prodotto' => 'd-none',
            'articolo' => 'd-none',
            'qta_min' => 'd-none',
            'qta_max' => 'd-none',
            'prefisso' => 'd-none',
            'prezzo' => 'd-none',
            'suffisso' => 'd-none',
            'sconto_articoli' => 'd-none',
            'iva' => 'd-none',
            NULL => 'no-wrap'
        ),
        'onclick' => array(
            NULL => 'event.stopPropagation();'
        ),
        '__restrict__' => array(
            '__label__' => array( 'NN' => true )
        ),
        '__sort__' => array(
            '__label__' => 'ASC'
        ),
    );

    /**
     * configurazione della pagina
     * ===========================
     * 
     * 
     * 
     * 
     */

    /**
     * dati delle tendine
     * ==================
     * 
     * 
     * 
     * 
     */

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

    /**
     * elaborazione risultati della vista
     * ==================================
     * 
     * 
     * 
     */

    // elaborazione righe
    if (!empty($ct['view']['data'])){
        foreach( $ct['view']['data'] as &$row ) {
            if( is_array( $row ) ) {

                $buttons = [];

                $row[ NULL ] = implode( $buttons );

            }

        }
    }
