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
	$m = DIR_MOD . '_03000.contenuti/';

	// dashboard contenuti
	$p['contenuti'] = array(
	    'sitemap'		=> false,
	    'title'			=> array( $l		=> 'contenuti' ),
	    'h1'			=> array( $l		=> 'contenuti' ),
	    'parent'		=> array( 'id'		=> NULL ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'contenuti.twig' ),
	    'macro'			=> array( $m . '_src/_inc/_macro/_contenuti.php' ),
		'auth'			=> array( 'groups'	=> array(	'roots', 'staff' ) ),
		'etc'			=> array( 'tabs'	=> array(	'contenuti',
														'contenuti.tools'
														 ) ),
		'menu'				=> array( 'admin'	=> array(	'' => 	array(	'label'		=> array( $l => 'contenuti' ),
																		'priority'	=> '3000' ) ) )														
	);

    // tools contenuti
	$p['contenuti.tools'] = array(
		'sitemap'			=> false,
		'icon'				=> '<i class="fa fa-cogs" aria-hidden="true"></i>',
	    'title'				=> array( $l		=> 'azioni' ),
	    'h1'				=> array( $l		=> 'azioni' ),
	    'parent'			=> array( 'id'		=> 'contenuti' ),
	    'template'			=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.tools.twig' ),
	    'macro'				=> array( $m . '_src/_inc/_macro/_contenuti.tools.php' ),
	    'auth'				=> array( 'groups'	=> array(	'roots', 'staff' ) ),
	    'etc'				=> array( 'tabs'	=> 'contenuti' )
	);

	// dashboard contenuti
	$p['contenuti.archivio'] = array(
	    'sitemap'		=> false,
	    'title'			=> array( $l		=> 'archivio contenuti' ),
	    'h1'			=> array( $l		=> 'archivio' ),
	    'parent'		=> array( 'id'		=> 'contenuti' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'contenuti.archivio.twig' ),
	    'macro'			=> array( $m . '_src/_inc/_macro/_contenuti.archivio.php' ),
		'auth'			=> array( 'groups'	=> array(	'roots', 'staff' ) ),
		'etc'			=> array( 'tabs'	=> array(	'contenuti.archivio',
														'contenuti.archivio.tools'
														 ) ),
		'menu'				=> array( 'admin'	=> array(	'' => 	array(	'label'		=> array( $l => 'archivio' ),
																		'priority'	=> '9900' ) ) )														
	);

    // tools archivio contenuti
	$p['contenuti.archivio.tools'] = array(
		'sitemap'			=> false,
		'icon'				=> '<i class="fa fa-cogs" aria-hidden="true"></i>',
	    'title'				=> array( $l		=> 'azioni' ),
	    'h1'				=> array( $l		=> 'azioni' ),
	    'parent'			=> array( 'id'		=> 'contenuti.archivio' ),
	    'template'			=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.tools.twig' ),
	    'macro'				=> array( $m . '_src/_inc/_macro/_contenuti.archivio.tools.php' ),
	    'auth'				=> array( 'groups'	=> array(	'roots', 'staff' ) ),
	    'etc'				=> array( 'tabs'	=> 'contenuti.archivio' )
	);
