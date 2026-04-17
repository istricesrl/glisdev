<?php

    /**
     * 
     * 
     * 
     * 
     * TODO documentare
     * 
     * 
     */

    // lingua di questo file
    $l = 'it-IT';

    // modulo di questo file
    $m = DIR_MOD . '_LI000.listini/';

    // tools archivio produzione
    $p['catalogo.listini.vendita.view'] = array(
        'sitemap'            => false,
        'title'                => array( $l        => 'listini vendita' ),
        'h1'                => array( $l        => 'listini vendita' ),
        'parent'            => array( 'id'        => 'catalogo' ),
        'template'            => array( 'path'    => '_src/_tpl/_athena/', 'schema' => 'default.view.twig' ),
        'macro'                => array( $m . '_src/_inc/_macro/_catalogo.listini.vendita.view.php' ),
        'auth'                => array( 'groups'    => array(    'roots', 'staff' ) ),
        'etc'                => array( 'tabs'    => array(    'catalogo.listini.vendita.view',
                                                            'catalogo.listini.acquisto.view',
                                                            'catalogo.listini.vendita.view.archiviati',
                                                            'catalogo.listini.vendita.stampe',
                                                            'catalogo.listini.vendita.tools' ) ),
        'menu'                => array( 'admin'    => array(    '' =>     array(    'label'        => array( $l => 'listini' ),
                                                                            'priority'    => '200' ) ) )
    );

    // geatione listini vendita
    $p['catalogo.listini.vendita.form'] = array(
        'sitemap'            => false,
        'title'                => array( $l        => 'catalogo listini vendita form' ),
        'h1'                => array( $l        => 'gestione' ),
        'parent'            => array( 'id'        => 'catalogo.listini.vendita.view' ),
        'template'            => array( 'path'    => '_src/_tpl/_athena/', 'schema' => 'catalogo.listini.vendita.form.twig' ),
        'macro'                => array( $m . '_src/_inc/_macro/_catalogo.listini.vendita.form.php' ),
        'auth'                => array( 'groups'    => array(    'roots', 'staff' ) ),
        'etc'                => array( 'tabs'    => array(    'catalogo.listini.vendita.form',
                                                            'catalogo.listini.vendita.form.tools' ) )
    );
