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
    if ($URI === '/cf') {
        require('_src/_api/_status/_cf.php');
        exit;
    }

    // navigatore geografia
    if ($URI === '/geo') {
        require('_src/_api/_status/_geo.php');
        exit;
    }

    // status del framework
    if ($URI === '/status') {
        require('_src/_api/_status/_framework.php');
        exit;
    }

    /**
     * gestione delle API (/api/...)
     * =============================
     * 
     * 
     */

    // API di login
    if ($URI === '/api/login') {
        require('_src/_api/_user.php');
        exit;
    }

    // API di logout
    if ($URI === '/api/logout') {
        $_GET['__logout__'] = 1;
        require('_src/_api/_user.php');
        exit;
    }

    // API di download generico: /var/<...> -> _src/_api/_download.php?__download__=var/...
    if (preg_match('#^/var/(.+)$#', $URI, $m)) {
        $_GET['__download__'] = 'var/'.$m[1];
        require('_src/_api/_download.php');
        exit;
    }

    // API per il mailing /mailing/<id>/var/<...>
    if (preg_match('#^/mailing/([0-9]+)/var/(.+)$#', $URI, $m)) {
        $_GET['__download__'] = 'var/'.$m[2];
        $_GET['__mailing__']  = $m[1];
        require('_src/_api/_download.php');
        exit;
    }

    // API per il mailing /mailing/<id>/<dst>/var/<...>
    if (preg_match('#^/mailing/([0-9]+)/([0-9]+)/var/(.+)$#', $URI, $m)) {
        $_GET['__download__']   = 'var/'.$m[3];
        $_GET['__mailing__']    = $m[1];
        $_GET['__mailing_dst__']= $m[2];
        require('_src/_api/_download.php');
        exit;
    }

    // API per OpenstreetMap
    if (preg_match('#^/tiles/([0-9]+)/([0-9]+)/([0-9]+)\.png$#', $URI, $m)) {
        $_GET['z']=$m[1]; $_GET['x']=$m[2]; $_GET['y']=$m[3];
        require('_src/_api/_osm.php');
        exit;
    }

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
        $_REQUEST['__ws__'] = $m[1];
        $_REQUEST['__id__'] = $m[2] ?? '';
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

    // API per la chiamata diretta dei job /job/<id>
    if (preg_match('#^/job/([0-9]+)?$#', $URI, $m)) {
        $_GET['__id__'] = $m[1] ?? '';
        require('_src/_api/_job.php');
        exit;
    }

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

    // task di generazione report /task/report/<name> o /task/report/<mod>/<name>
    if (preg_match('#^/task/report/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $name = $m[1];
        if (file_exists("src/api/task/report/$name.php")) {
            require("src/api/task/report/$name.php");
            exit;
        }
        if (file_exists("_src/_api/_task/_report/_$name.php")) {
            require("_src/_api/_task/_report/_$name.php");
            exit;
        }
    }

    // task di generazione report dei moduli /task/report/<mod>/<name>
    if (preg_match('#^/task/report/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        [$all,$mod,$name] = $m;
        if (file_exists("mod/$mod/src/api/task/report/$name.php")) {
            require("mod/$mod/src/api/task/report/$name.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_task/_report/_$name.php")) {
            require("_mod/_$mod/_src/_api/_task/_report/_$name.php");
            exit;
        }
    }

    /**
     * report (/report/...)
     * ====================
     * 
     * 
     * 
     * 
     */

    // gestione dei report base /report/<report>
    if (preg_match('#^/report/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $rep = $m[1];
        if (file_exists("src/api/report/$rep.php")) {
            require("src/api/report/$rep.php");
            exit;
        }
        if (file_exists("_src/_api/_report/_$rep.php")) {
            require("_src/_api/_report/_$rep.php");
            exit;
        }
    }

    // gestione dei report dei moduli /report/<mod>/<report>
    if (preg_match('#^/report/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        [$all,$mod,$rep] = $m;
        if (file_exists("mod/$mod/src/api/report/$rep.php")) {
            require("mod/$mod/src/api/report/$rep.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_report/_$rep.php")) {
            require("_mod/_$mod/_src/_api/_report/_$rep.php");
            exit;
        }
    }

    /**
     * status (/status/...)
     * ====================
     * 
     * 
     * 
     */

    // gestione dei report di stato base /status/<status>
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

    // gestione dei report di stato dei moduli /status/<mod>/<status>
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

    // gestione delle stampe base /print/<print>
    if (preg_match('#^/print/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        $pr = $m[1];
        if (file_exists("src/api/print/$pr.php")) {
            require("src/api/print/$pr.php");
            exit;
        }
        if (file_exists("_src/_api/_print/_$pr.php")) {
            require("_src/_api/_print/_$pr.php");
            exit;
        }
    }

    // gestione delle stampe dei moduli /print/<mod>/<print>
    if (preg_match('#^/print/([A-Za-z0-9_\-\.]+)/([A-Za-z0-9_\-\.]+)$#', $URI, $m)) {
        [$all,$mod,$pr] = $m;
        if (file_exists("mod/$mod/src/api/print/$pr.php")) {
            require("mod/$mod/src/api/print/$pr.php");
            exit;
        }
        if (file_exists("_mod/_$mod/_src/_api/_print/_$pr.php")) {
            require("_mod/_$mod/_src/_api/_print/_$pr.php");
            exit;
        }
    }

    /**
     * gestione dei contenuti
     * ======================
     * 
     * 
     * 
     */

    // favicon
    if ($URI === '/favicon.ico') {
        if (!file_exists('favicon.ico') && file_exists('_src/_img/_favicon.ico')) {
            die( file_get_contents('_src/_img/_favicon.ico') );
        }
    }

    // robots override per STATUS=DEV/TEST
    $ENV_STATUS = $_SERVER['STATUS'] ?? getenv('STATUS') ?? '';
    if ($URI === '/robots.txt') {
        if ($ENV_STATUS === 'DEV' || $ENV_STATUS === 'TEST') {
            if (file_exists('_etc/_robots/_deny.txt')) 
                die( file_get_contents('_etc/_robots/_deny.txt') );
        }
        if (file_exists('etc/robots/robots.txt')) die( file_get_contents('etc/robots/robots.txt') );
        if (file_exists('_etc/_robots/_robots.txt')) die( file_get_contents('_etc/_robots/_robots.txt') );
    }

    // sitemap per host in formato XML
    if ($URI === '/sitemap.xml') {
        $p = 'var/sitemap/sitemap.'.$HOST.'.xml';
        if (file_exists($p)) die( file_get_contents($p) );
    }

    // sitemap per host in formato CSV
    if ($URI === '/sitemap.csv') {
        $p = 'var/sitemap/sitemap.'.$HOST.'.csv';
        if (file_exists($p)) die( file_get_contents($p) );
    }

    // supporto WebP automatico
    if (!preg_match('~\.webp$~i', $URI)) {
        $rel = ltrim($URI, '/');
        if ($rel !== '' && !file_exists($rel) && file_exists($rel.'.webp')) {
            die( file_get_contents($rel.'.webp') );
        }
    }

    /**
     * directory ad accesso diretto
     * ----------------------------
     * 
     * 
     */

    // usr/pages e _usr/_pages se il file esiste realmente
    $rel = ltrim($URI, '/');
    if ($rel !== '') {
        if (file_exists('usr/pages/'.$rel))  die( file_get_contents('usr/pages/'.$rel) );
        if (file_exists('_usr/_pages/'.$rel)) die( file_get_contents('_usr/_pages/'.$rel) );
    }

    // var/cache/css/* -> accesso diretto
    if (preg_match('#^/var/cache/css/.*#i', $URI) && file_exists(ltrim($URI,'/'))) {
        die( file_get_contents(ltrim($URI,'/')) );
    }

    /**
     * gestione dei contenuti statici
     * ------------------------------
     * 
     * 
     */

    // se arrivo qui e il file esiste realmente, lo servo
    if ($rel !== '' && file_exists($rel)) {
        $ext = strtolower(pathinfo($rel, PATHINFO_EXTENSION));
        if (in_array($ext, ['htm','html'])) {
            die( file_get_contents($rel) );
        } elseif (in_array($ext, ['jpg','jpeg','png','gif','ico','webp'])) {
            die( file_get_contents($rel) );
        } elseif (in_array($ext, ['css','js'])) {
            die( file_get_contents($rel) );
        } else {
            die( file_get_contents($rel));
        }
    }

    /**
     * gestione delle pagine (catch-all)
     * ---------------------------------
     * 
     */

    // recupero $_SERVER['REDIRECT_URL'] se non esiste
    if( ! isset( $_SERVER['REDIRECT_URL'] ) ) {

        // parto dalla REQUEST_URI e tolgo la query string
        $uri = $_SERVER['REQUEST_URI'];
        $uri = explode( '?', $uri, 2 )[0];

        $_SERVER['REDIRECT_URL'] = $uri;
        $_REQUEST['__rw__']      = $uri;

        if( preg_match( '#^/([A-Za-z0-9._\-/]+)\.([a-z]{2}-[A-Z]{2})\.html?$#', $uri, $m ) ) {

            // nomepagina.xx-XX.html / nomepagina.xx-XX.htm
            $_REQUEST['__lg__'] = $m[2];
            $clean = '/' . $m[1];

        } elseif( preg_match( '#^/([A-Za-z0-9._\-/]+)\.html?$#', $uri, $m ) ) {

            // nomepagina.html / nomepagina.htm
            $clean = '/' . $m[1];

        } else {

            $clean = $uri;
        }

        $_SERVER['REDIRECT_URL'] = $clean;
        $_REQUEST['__rw__']      = $clean;

    }

    // tokenizzazione di __rw__
    if (isset($_REQUEST['__rw__'])) {
        $_REQUEST['__rp__'] = explode('/', trim($_REQUEST['__rw__'], '/'));
        unset($_REQUEST['__rw__']);
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
