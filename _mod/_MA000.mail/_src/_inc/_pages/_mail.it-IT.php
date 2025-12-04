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
    $m = DIR_MOD . '_MA000.mail/';

    // vista mail in uscita
	$p['mail.out.view'] = array(
	    'sitemap'		=> false,
	    'title'			=> array( $l		=> 'mail in uscita' ),
	    'h1'			=> array( $l		=> 'mail in uscita' ),
	    'tab'			=> array( $l		=> 'in uscita' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.view.twig' ),
	    'macro'			=> array( $m . '_src/_inc/_macro/_mail.out.view.php' ),
	    'parent'		=> array( 'id'		=> 'strumenti' ),
	    'auth'			=> array( 'groups'	=> array(	'roots' ) ),
		'etc'			=> array( 'tabs'	=> array(	'mail.out.view',
													'mail.sent.view',
													'mail.template.view',
													'mail.tools'
												 ) ),
		'menu'			=> array( 'admin'	=> array(	'' => 	array(	'label'		=> array( $l => 'mail' ),
								'priority'	=> '950' ) ) )
	);

    // gestione mail in uscita
	$p['mail.out.form'] = array(
	    'sitemap'		=> false,
	    'title'		=> array( $l		=> 'gestione' ),
	    'h1'		=> array( $l		=> 'gestione' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'mail.out.form.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.out.form.php' ),
	    'parent'		=> array( 'id'		=> 'mail.out.view' ),
	    'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> array(	'mail.out.form',
													// 'mail.out.form.file',
													'mail.out.form.tools'
												 ) ),
	);

    // RELAZIONI CON IL MODULO FILE
    if( in_array( "FI000.file", $cf['mods']['active']['array'] ) ) {
        arrayInsertBefore( 'mail.out.form.tools', $p['mail.out.form']['etc']['tabs'], 'mail.out.form.file' );
    }

    // gestione strumenti mail in uscita
	$p['mail.out.form.tools'] = array(
	    'sitemap'		=> false,
		'icon'		=> '<i class="fa fa-cogs" aria-hidden="true"></i>',
	    'title'		=> array( $l		=> 'strumenti code mail' ),
	    'h1'		=> array( $l		=> 'strumenti' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.tools.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.out.form.tools.php' ),
	    'parent'		=> array( 'id'		=> 'mail.out.view' ),
	    'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> $p['mail.out.form']['etc']['tabs'] )
	);

    // vista mail inviate
	$p['mail.sent.view'] = array(
	    'sitemap'		=> false,
	    'title'		=> array( $l		=> 'mail inviate' ),
	    'h1'		=> array( $l		=> 'mail inviate' ),
	    'tab'		=> array( $l		=> 'inviate' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.view.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.sent.view.php' ),
	    'parent'		=> array( 'id'		=> 'strumenti' ),
	    'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> $p['mail.out.view']['etc']['tabs'] )
	);

    // gestione mail inviate
	$p['mail.sent.form'] = array(
	    'sitemap'		=> false,
	    'title'		=> array( $l		=> 'gestione' ),
	    'h1'		=> array( $l		=> 'gestione' ),
	    'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'mail.sent.form.twig' ),
	    'macro'		=> array( $m . '_src/_inc/_macro/_mail.sent.form.php' ),
	    'parent'		=> array( 'id'		=> 'mail.sent.view' ),
	    'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> array(	'mail.sent.form',
													'mail.sent.form.tools'
												 ) ),
	);

	// strumenti mail
	$p['mail.tools'] = array(
		'sitemap'		=> false,
		'icon'		=> '<i class="fa fa-cogs" aria-hidden="true"></i>',
		'title'		=> array( $l		=> 'strumenti mail' ),
		'h1'		=> array( $l		=> 'strumenti mail' ),
		'template'		=> array( 'path'	=> '_src/_tpl/_athena/', 'schema' => 'default.tools.twig' ),
		'macro'		=> array( $m . '_src/_inc/_macro/_mail.tools.php' ),
		'parent'		=> array( 'id'		=> 'strumenti' ),
		'auth'		=> array( 'groups'	=> array(	'roots' ) ),
		'etc'		=> array( 'tabs'	=> $p['mail.out.view']['etc']['tabs'] )
	);

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
		'icon'			=> '<i class="fa fa-file-text-o" aria-hidden="true"></i>',
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
		'icon'		=> '<i class="fa fa-folder-open-o" aria-hidden="true"></i>',
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

