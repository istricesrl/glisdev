<?php

    /**
     * Front controller che emula il comportamento del file .htaccess negli ambienti in cui
     * non è possibile utilizzare Apache (ad esempio server Windows con IIS o Nginx).
     * 
     * 
     * per far passare tutto il traffico web a questo file, è necessario configurare il server web
     * Nginx o IIS in modo appropriato. Per Nginx inserire questo blocco di configurazione:
     * 
     * ```
     * location / {
     *    try_files "" /index.php$is_args$args;
     * }
     * ```
     * 
     * nel blocco server del sito web. Se è presente un blocco come questo, rimuoverlo:
     * 
     * ```
     * if (-f $request_filename) {
     *   break;
     * }
     * ```
     * 
     * in quanto farebbe servire i file statici direttamente senza passare per il front controller.
     * 
     */

    // percorso di inclusione del framework
    define( 'INCLUDE_SUBDIR', __DIR__ . '/_src/' );

    // URI corrente
    $URI = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?? '/';

    // debug
    // die( $URI );

    /**
     * scorciatoie
     * ===========
     * 
     * 
     */

    // current.release
    if ($URI === '/current.release' && file_exists('_etc/_current.release')) 
        die( file_get_contents('_etc/_current.release'));

    // current.version
    if ($URI === '/current.version' && file_exists('_etc/_current.version'))
        die( file_get_contents('_etc/_current.version'));

    // manuale PDF
    if ($URI === '/docs/pdf' && file_exists('_usr/_docs/_pdf/refman.pdf')) {
        die( file_get_contents('_usr/_docs/_pdf/refman.pdf'));
    }

    // documentazione HTML
    if (preg_match('#^/docs/([A-Za-z0-9_\-\/\.]*)$#', $URI, $m)) {
        $t = '_usr/_docs/_html/'.norm_path($m[1]);
        if (file_exists($t)) die(file_get_contents($t));
    }

    // navigatore array $cf
    if ($URI === '/cf')  require('_src/_api/_status/_cf.php');

    // navigatore geografia
    if ($URI === '/geo') require('_src/_api/_status/_geo.php');

    // status del framework
    if ($URI === '/status') require('_src/_api/_status/_framework.php');

    /**
     * gestione delle API (/api/...)
     * =============================
     * 
     * 
     */

    // API di login e logout

    // API di download

    // API per il mailing

    // API per OpenstreetMap

    /**
     * API generiche
     * -------------
     * 
     */

    // /api/<api> -> src/api/<api>.php o _src/_api/_<api>.php
    if (preg_match('#^/api/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $api = $m[1];
        if (file_exists("src/api/$api.php")) {
            require("src/api/$api.php");
            exit;
        }
        if (file_exists("_src/_api/_$api.php")) {
            require("_src/_api/_$api.php");
            exit;
        }
    }

    // /api/<mod>/<api> -> mod/<mod>/src/api/<api>.php o _mod/_<mod>/_src/_api/_<api>.php
    if (preg_match('#^/api/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9\.]+)$#', $URI, $m)) {
        [$all,$mod,$api] = $m;
        if (file_exists("mod/$mod/src/api/$api.php")) {
            require("mod/$mod/src/api/$api.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_$api.php")) {
            require("_mod/_$mod/_src/_api/_$api.php");
            exit;
        }
    }

    // REST generiche: /api/<entita>[/<id>]
    if (preg_match('#^/api/([A-Za-z0-9_\-]+)(?:/([A-Za-z0-9\.\-]+))?$#', $URI, $m)) {
        $_GET['__ws__'] = $m[1];
        $_GET['__id__'] = $m[2] ?? '';
        require('_src/_api/_rest.php');
        exit;
    }

    // protezione da loop pages
    if ($URI === '/_src/_api/_pages.php') { exit; }

    /**
     * gestione dei job (/job/...)
     * ===========================
     * 
     * 
     * 
     */

    /**
     * gestione dei task (/task/...)
     * =============================
     * 
     */

    // task/<task> -> src/api/task/<task>.php o _src/_api/_task/_<task>.php
    if (preg_match('#^/task/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $task = $m[1];
        if (file_exists("src/api/task/$task.php")) {
            require("src/api/task/$task.php");
            exit;
        }
        if (file_exists("_src/_api/_task/_$task.php")) {
            require("_src/_api/_task/_$task.php");
            exit;
        }
    }

    // task/<mod>/<task>
    if (preg_match('#^/task/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        [$all,$mod,$task] = $m;
        if (file_exists("mod/$mod/src/api/task/$task.php")) {
            require("mod/$mod/src/api/task/$task.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_task/_$task.php")) {
            require("_mod/_$mod/_src/_api/_task/_$task.php");
            exit;
        }
    }

    /**
     * task di popolazione dei report
     * ------------------------------
     * 
     */

    /**
     * report (/report/...)
     * ====================
     * 
     * 
     * 
     * 
     */

    /**
     * status (/status/...)
     * ====================
     * 
     * 
     * 
     */

    // gestione dei report di stato base
    if (preg_match('#^/status/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $st = $m[1];
        if (file_exists("src/api/status/$st.php")) {
            require("src/api/status/$st.php");
            exit;
        }
        if (file_exists("_src/_api/_status/_$st.php")) {
            require("_src/_api/_status/_$st.php");
            exit;
        }
    }

    // gestione dei report di stato dei moduli
    if (preg_match('#^/status/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        [$all,$mod,$st] = $m;
        if (file_exists("mod/$mod/src/api/status/$st.php")) {
            require("mod/$mod/src/api/status/$st.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_status/_$st.php")) {
            require("_mod/_$mod/_src/_api/_status/_$st.php");
            exit;
        }
    }

    /**
     * stampe (/print/...)
     * ===================
     * 
     * 
     * 
     */

    /**
     * gestione dei contenuti
     * ======================
     * 
     * 
     * 
     */

    /**
     * gestione delle pagine (catch-all)
     * ---------------------------------
     * 
     */

    // recupero $_SERVER['REDIRECT_URL'] se non esiste
    if( ! isset( $_SERVER['REDIRECT_URL'] ) ) {
        $_REQUEST['__rw__'] = $_SERVER['REDIRECT_URL'] = $_SERVER['REQUEST_URI'];
        if( preg_match( '#^/([A-Za-z0-9._\-/]+)\.([a-z]{2}-[A-Z]{2})\.html?$#', $_SERVER['REQUEST_URI'], $m ) ) {
            $_SERVER['REDIRECT_URL'] = '/'.$m[1].'.html';
            $_REQUEST['__lg__'] = $m[2];
        }
        $_REQUEST['__rw__'] = $_SERVER['REQUEST_URI'] = $_SERVER['REDIRECT_URL'] . ( $_SERVER['QUERY_STRING'] ? '?' . $_SERVER['QUERY_STRING'] : '' );
        if( preg_match( '#^/([A-Za-z0-9._\-/]+)\.html?$#', $_SERVER['REDIRECT_URL'], $m ) ) {
            $_REQUEST['__rw__'] = $_SERVER['REDIRECT_URL'] = '/'.$m[1];
        }
    }

    // tokenizzazione di __rw__
    if( isset( $_REQUEST['__rw__'] ) ) {
        $_REQUEST['__rp__'] = explode( '/', trim( $_REQUEST['__rw__'], '/' ) );
        unset( $_REQUEST['__rw__'] );
    }

    // Home
    if ($URI === '/' || $URI === '') {
        require '_src/_api/_pages.php';
        exit;
    }

    // nomepagina.xx-XX.html
    if (preg_match('#^/([A-Za-z0-9._\-/]+)\.([a-z]{2}-[A-Z]{2})\.html?$#', $URI, $m)) {
        $_GET['__rw__'] = $m[1];
        $_GET['__lg__'] = $m[2];
        require '_src/_api/_pages.php';
        exit;
    }

    // nomefile[.estensione] -> pages con __rw__=nomefile
    if (preg_match('#^/([A-Za-z0-9._\-/]*[A-Za-z0-9_-])(?:\.[A-Za-z0-9]+)?$#', $URI, $m)) {
        $_GET['__rw__'] = ltrim($m[1],'/');
        require '_src/_api/_pages.php';
        exit;
    }
