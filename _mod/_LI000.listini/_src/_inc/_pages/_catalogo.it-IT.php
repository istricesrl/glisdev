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
        'macro'                => array( $m . '_src/_inc/_macro/_catalogo.listini.view.php' ),
        'auth'                => array( 'groups'    => array(    'roots', 'staff' ) ),
        'etc'                => array( 'tabs'    => array(    'catalogo.listini.vendita.view',
                                                            'catalogo.listini.acquisto.view',
                                                            'catalogo.listini.view.archiviati',
                                                            'catalogo.listini.stampe',
                                                            'catalogo.listini.tools' ) ),
        'menu'                => array( 'admin'    => array(    '' =>     array(    'label'        => array( $l => 'listini' ),
                                                                            'priority'    => '200' ) ) )
    );
