<?php

    /**
     * Front controller che emula il comportamento del .htaccess fornito
     * Funziona senza accesso alla config Nginx/Apache.
     */

    declare(strict_types=1);

    /* ======================== CONFIG DI BASE ======================== */

    $DOCROOT = rtrim(str_replace('\\','/', __DIR__), '/'); // webroot reale su disco
    $URI     = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?? '/';
    $METHOD  = $_SERVER['REQUEST_METHOD'] ?? 'GET';
    $HOST    = $_SERVER['HTTP_HOST'] ?? '';
    $QS      = $_SERVER['QUERY_STRING'] ?? '';

    /* ======================== PREPARAZIONE FRAMEWORK ======================== */

    // recupero $_SERVER['REDIRECT_URL'] se non esiste
    if( ! isset( $_SERVER['REDIRECT_URL'] ) ) {
        $_REQUEST['__rw__'] = $_SERVER['REDIRECT_URL'] = $_SERVER['REQUEST_URI'];
        // prelevo il suffisso per lingua (se presente)
        if( preg_match( '#^/([A-Za-z0-9._\-/]+)\.([a-z]{2}-[A-Z]{2})\.html?$#', $_SERVER['REQUEST_URI'], $m ) ) {
            $_SERVER['REDIRECT_URL'] = '/'.$m[1].'.html';
            $_REQUEST['__lg__'] = $m[2];
        }
        // rimuovo il suffisso dalla lingua dalla REQUEST_URI
        $_REQUEST['__rw__'] = $_SERVER['REQUEST_URI'] = $_SERVER['REDIRECT_URL'] . ( $_SERVER['QUERY_STRING'] ? '?' . $_SERVER['QUERY_STRING'] : '' );
        // rimuovo l'estensione .html/.htm dalla REQUEST_URI
        if( preg_match( '#^/([A-Za-z0-9._\-/]+)\.html?$#', $_SERVER['REDIRECT_URL'], $m ) ) {
            $_REQUEST['__rw__'] = $_SERVER['REDIRECT_URL'] = '/'.$m[1];
        }
    }

    // tokenizzazione di __rw__
    if( isset( $_REQUEST['__rw__'] ) ) {
        $_REQUEST['__rp__'] = explode( '/', trim( $_REQUEST['__rw__'], '/' ) );
        unset( $_REQUEST['__rw__'] );
    }

    require_once '_src/_config.php';

    /* ======================== PAGINE (catch-all) ======================== */

    // Home
    if ($URI === '/' || $URI === '') {
        require '_src/_api/_pages.php';
    }

    // nomepagina.xx-XX.html
    if (preg_match('#^/([A-Za-z0-9._\-/]+)\.([a-z]{2}-[A-Z]{2})\.html?$#', $URI, $m)) {
        $_GET['__rw__'] = $m[1];
        $_GET['__lg__'] = $m[2];
        require '_src/_api/_pages.php';
    }

    // nomefile[.estensione] -> pages con __rw__=nomefile
    if (preg_match('#^/([A-Za-z0-9._\-/]*[A-Za-z0-9_-])(?:\.[A-Za-z0-9]+)?$#', $URI, $m)) {
        $_GET['__rw__'] = ltrim($m[1],'/');
        require '_src/_api/_pages.php';
    }
