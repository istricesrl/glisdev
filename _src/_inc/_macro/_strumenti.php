<?php

    /**
     * macro dashboard tools
     *
     *
     *
     * TODO documentare
     *
     */

    // gruppi di controlli
	$ct['page']['contents']['metros'] = array(
	    '01.esportazioni' => array(
			'label' => 'esportazioni'
		),
	    '02.importazioni' => array(
			'label' => 'importazioni'
		),
	    '03.elaborazioni' => array(
			'label' => 'elaborazioni'
		),
	    '04.cache' => array(
			'label' => 'cache'
		),
	    '05.static' => array(
			'label' => 'viste statiche'
        ),
        '06.logs' => array(
            'label' => 'logs'
        )
	);

    // aggiornamento cache
	if( isset( $cf['memcache']['connection'] ) ) {
	    $ct['page']['contents']['metro']['04.cache'][] = array(
		'ws' => 'task/memcache.clean',
		'icon' => NULL,
		'fa' => 'fa-regular fa-clock',
		'title' => 'aggiornamento memcache',
		'text' => 'forza il flush della cache dati'
	    );
	    timerCheck( $cf['speed'], '-> memcache' );
	}

	if( file_exists( DIR_VAR_CACHE_TWIG ) ) {
	    $ct['page']['contents']['metro']['04.cache'][] = array(
		'ws' => 'task/twig.cache.clean',
		'icon' => NULL,
		'fa' => 'fa-recycle',
		'title' => 'aggiornamento cache di Twig',
		'text' => 'cancella la cache dei template'
	    );
	    timerCheck( $cf['speed'], '-> cache Twig' );
	}

	if( file_exists( DIR_VAR_CACHE_PAGES ) ) {
	    $ct['page']['contents']['metro']['04.cache'][] = array(
		'ws' => 'task/pages.cache.clean',
		'icon' => NULL,
		'fa' => 'fa-eraser',
		'title' => 'aggiornamento cache pagine',
		'text' => 'cancella la cache statica delle pagine'
	    );
	    timerCheck( $cf['speed'], '-> cache Twig' );
	}

    // gestione di default dei tools
	require DIR_SRC_INC_MACRO . '_default/_default.tools.php';
