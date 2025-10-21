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
        'table' => 'pagine',
        'open' => array(
            'page' => 'contenuti.pagine.form',
            'table' => 'pagine'
        ),
        'cols' => array(
            'id' => '#',
            'id_sito' => 'sito',
            '__label__' => 'pagina',
            'template' => 'template',
            'schema_html' => 'schema',
            'tema_css' => 'tema',
            NULL => 'azioni'
        ),
        'class' => array(
            'id' => 'd-none',
            '__label__' => 'no-wrap text-start',
            'template' => 'no-wrap text-start',
            'schema_html' => 'no-wrap text-start',
            'tema_css' => 'no-wrap text-start',
            NULL => 'no-wrap'
        ),
        'onclick' => array(
            NULL => 'event.stopPropagation();'
        ),
        '__restrict__' => array(
            'data_archiviazione' => array('NL' => true)
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

    $ct['etc']['include']['filters'] = 'inc/contenuti.pagine.view.filters.twig';

    /**
     * dati delle tendine
     * ==================
     * 
     * 
     * 
     * 
     */

    // tendina siti
    $ct['etc']['select']['siti'] = $cf['sites'];

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
    foreach ($ct['view']['data'] as &$row) {
        if (is_array($row)) {

            if( ! empty( $row['id_sito'] ) ) {
                if( isset( $cf['sites'][ $row['id_sito'] ] ) )
                    $row['id_sito'] = $cf['sites'][ $row['id_sito'] ]['__label__'];
                else
                    $row['id_sito'] = 'sito non definito';
            } else {
                $row['id_sito'] = 'nessun sito';
            }

            $buttons = [];

            $row[NULL] = implode($buttons);

        }
    }
