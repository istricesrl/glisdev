<?php

    /**
     * 
     * 
     * 
     * 
     * 
     * TODO documentare
     * 
     */

    // lingua di questo file
    $l = 'it-IT';

    // modulo di questo file
    $m = DIR_MOD . '_VI000.video/';

    // gestione catalogo.prodotti form video
    $p['catalogo.prodotti.form.video'] = array(
        'sitemap'            => false,
        'icon'                => '<i class="fa fa-video" aria-hidden="true"></i>',
        'title'                => array( $l        => 'video' ),
        'h1'                => array( $l        => 'video' ),
        'parent'            => array( 'id'        => 'catalogo.prodotti.view' ),
        'template'            => array( 'path'    => '_src/_tpl/_athena/', 'schema' => 'catalogo.prodotti.form.video.twig' ),
        'macro'                => array( $m . '_src/_inc/_macro/_catalogo.prodotti.form.video.php' ),
        'auth'                => array( 'groups'    => array(    'roots', 'staff' ) ),
        'etc'                => array( 'tabs'    => 'catalogo.prodotti.form' )
    );
