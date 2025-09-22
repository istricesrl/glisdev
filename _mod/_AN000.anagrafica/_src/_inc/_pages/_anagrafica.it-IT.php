<?php

    /**
     * definizione delle pagine per la gestione dell'anagrafica
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
    $m = DIR_MOD . '_AN000.anagrafica/';

    // vista anagrafica
	$p['anagrafica.view']	= array(
	    'sitemap'			=> false,
	    'title'				=> array( $l		=> 'anagrafica' ),
	    'h1'				=> array( $l		=> 'anagrafica' ),
	    'parent'			=> array( 'id'		=> NULL ),
	    'template'			=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.view.twig' ),
	    'macro'				=> array( $m . '_src/_inc/_macro/_anagrafica.view.php' ),
	    'auth'				=> array( 'groups'	=> array(	'roots', 'staff' ) ),
	    'etc'				=> array( 'tabs'	=> array(	'anagrafica.view',
															'anagrafica.archivio.view',
															'anagrafica.stats',
															'anagrafica.stampe',
															'anagrafica.tools' ) ),
	    'menu'				=> array( 'admin'	=> array(	'' => 	array(	'label'		=> array( $l => 'anagrafica' ),
																			'priority'	=> '050' ) ) )
	);

    // gestione anagrafica
	$p['anagrafica.form'] = array(
	    'sitemap'			=> false,
	    'title'				=> array( $l		=> 'gestione' ),
	    'h1'				=> array( $l		=> 'gestione' ),
	    'parent'			=> array( 'id'		=> 'anagrafica.view' ),
	    'template'			=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'anagrafica.form.twig' ),
	    'macro'				=> array( $m . '_src/_inc/_macro/_anagrafica.form.php' ),
	    'auth'				=> array( 'groups'	=> array(	'roots', 'staff' ) ),
	    'etc'				=> array( 'tabs'	=> array(	'anagrafica.form',
															'anagrafica.form.informazioni',
															'anagrafica.form.relazioni',
															'anagrafica.form.amministrazione',
															'anagrafica.form.cliente',
															'anagrafica.form.fornitore',
															'anagrafica.form.collaboratore',
															'anagrafica.form.immagini',
															'anagrafica.form.video',
															'anagrafica.form.audio',
															'anagrafica.form.file',
															'anagrafica.form.metadati',
															'anagrafica.form.archiviazione',
															'anagrafica.form.stats',
															'anagrafica.form.stampe',
															'anagrafica.form.tools' ) )
	);
