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
    $m = DIR_MOD . '_TE000.template/';

    // vista template mail
	$p['mail.template.view'] = array(
	    'sitemap'		=> false,
	    'title'		=> array( $l		=> 'template mail' ),
		'h1'		=> array( $l		=> 'template mail' ),
		'tab'		=> array( $l		=> 'template' ),
	    'template'	=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.view.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.template.view.php' ),
		'parent'	=> array( 'id'		=> 'strumenti' ),
	    'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> $p['mail.out.view']['etc']['tabs'] )
	);

	// gestione template mail
	$p['mail.template.form'] = array(
		'sitemap'		=> false,
		'title'		=> array( $l		=> 'gestione' ),
		'h1'		=> array( $l		=> 'gestione' ),
		'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'mail.template.form.twig' ),
		'macro'		=> array( $m . '_src/_inc/_macro/_mail.template.form.php' ),
		'parent'		=> array( 'id'		=> 'mail.template.view' ),
		'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> array(	'mail.template.form',
												'mail.template.form.testo',
												'mail.template.form.file',
												'mail.template.form.tools' ) ),
	);

	// form template mail testo
	$p['mail.template.form.testo'] = array(
	    'sitemap'		=> false,
		'icon'			=> '<i class="fa-regular fa-file-text" aria-hidden="true"></i>',
	    'title'		=> array( $l		=> 'testo' ),
	    'h1'		=> array( $l		=> 'testo' ),
	    'parent'		=> array( 'id'		=> 'mail.template.view' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'mail.template.form.testo.twig' ),
		'macro'		=> array( $m . '_src/_inc/_macro/_mail.template.form.testo.php' ),
		'etc'		=> array( 'tabs'	=> $p['mail.template.form']['etc']['tabs'] ),
		'auth'		=> array( 'groups'	=> array(	'roots' ) )
	);

	// gestione template file
	$p['mail.template.form.file'] = array(
		'sitemap'		=> false,
		'icon'		=> '<i class="fa-regular fa-folder-open" aria-hidden="true"></i>',
		'title'		=> array( $l		=> 'file' ),
		'h1'		=> array( $l		=> 'file' ),
		'parent'		=> array( 'id'		=> 'mail.template.view' ),
		'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'mail.template.form.file.twig' ),
		'macro'		=> array( $m . '_src/_inc/_macro/_mail.template.form.file.php' ),
		'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> $p['mail.template.form']['etc']['tabs'] )
	);

	// gestione mail strumenti
	$p['mail.template.form.tools'] = array(
	    'sitemap'		=> false,
		'icon'		=> '<i class="fa fa-cogs" aria-hidden="true"></i>',
	    'title'		=> array( $l		=> 'azioni template mail' ),
	    'h1'		=> array( $l		=> 'azioni template mail' ),
		'parent'		=> array( 'id'		=> 'mail.template.view' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.tools.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.template.form.tools.php' ),
	    'auth'		=> array( 'groups'	=> array(	'roots', 'staff' ) ),
	    'etc'		=> array( 'tabs'	=> $p['mail.template.form']['etc']['tabs'] )
	);

