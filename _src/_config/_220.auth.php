<?php

    /**
     * questo file gestisce il logout
     *
     *
     *
     *
     * meccanismo di logout
     * ====================
     * Il logout dalla piattaforma può avvenire in due modi:
     *
     * - invio dati tramite $_REQUEST
     * - logout implicito per scadenza della sessione
     *
     * Il logout tramite $_REQUEST prevede l'invio al framework di un qualsiasi valore per la
     * chiave logout; un blocco dati simile è facile da realizzare, ad esempio:
     *
     * \code{.html}
     * <form method="post">
     *   <input type="hidden" name="__logout__" value="1">
     *   <input type="submit">
     * </form>
     * \endcode
     *
     * Volendo si può effettuare il logout anche tramite parametri GET aggiunti all'URL:
     *
     * http://glisweb.example.bho?__logout__=1
     *
     *
     * definizione di meccanismi custom per il logout
     * ==============================================
     *
     *
     *
     *
     *
     *
     *
     * TODO documentare
     * TODO invalidare l'API key
     *
     *
     */

    /**
     * calcolo della scadenza della sessione
     * =====================================
     * 
     * 
     * 
     */

    // tempo di riferimento
    $cf['auth']['expire'] = time() - SESSION_LIMIT;

    // verifica tempo di sessione
    if( $_SESSION['used'] <= $cf['auth']['expire'] ) {

        // logout implicito per timeout
        $_REQUEST['__logout__'] = true;

        // log
            logger( 'logout implicito per timeout: ' . $_SESSION['used'] . ' <= ' . $cf['auth']['expire'], 'session', LOG_NOTICE );

    } else {

        // log
            logger( 'sessione ancora attiva: ' . $_SESSION['used'] . ' > ' . $cf['auth']['expire'], 'session' );

    }

    /**
     * esecuzione del logout
     * =====================
     * 
     * 
     * 
     */

    // ...
    if( isset( $cf['auth']['index']['users'] ) ) {
        if( isset( $cf['session']['account']['username'] ) && ! empty( $cf['session']['account']['username'] ) ) {
            if( ! in_array( $_SESSION['id'], array_keys( $cf['auth']['index']['users'][ $cf['session']['account']['username'] ] ) ) ) {
                $_REQUEST['__logout__'] = true;
                logger( 'logout richiesto per disconnessione dal multisito', 'auth', LOG_NOTICE );
            }
        }
    }

    // intercetto eventuali tentativi di logout
    if( isset( $_REQUEST['__logout__'] ) ) {
        if( isset( $cf['session']['account']['username'] ) ) {

            // ...
            $cf['auth']['status'] = LOGIN_LOGOUT;

            // rimuovo la sessione da redis
            $cf['auth']['index']['users'][ $cf['session']['account']['username'] ] = array();
            if( ! empty( $cf['redis']['connection'] ) ) {
                $cf['redis']['connection']->set(
                    REDIS_MULTISITE_SEED,
                    json_encode( $cf['auth']['index'] )
                );
            }

            // svuoto selettivamente la $_SESSION
            foreach( $_SESSION as $k => $v ) {
                if( ! in_array( $k, array( 'id', 'used' ) ) ) {
                    unset( $_SESSION[ $k ] );
                }
            }

            // log
            logger( 'logout richiesto esplicitamente: ' . $_SESSION['id'], 'auth' );

        }

    }

    // ...
    $cf['session']['auth']['status'] = $cf['auth']['status'];

    /**
     * URL di ritorno per i multisiti
     * ==============================
     * 
     * 
     * 
     */

    // ...
    if( isset( $_SESSION['__back_to_url__'] ) && $cf['auth']['status'] == LOGIN_SUCCESS ) {

        $back = $_SESSION['__back_to_url__'];

        if( isset( $cf['session']['jwt']['string'] ) ){
            $back .= ( parse_url( $_SESSION['__back_to_url__'], PHP_URL_QUERY ) ? '&' : '?' ) . 'j=' . $cf['session']['jwt']['string'];
        }

        header( 'location: ' . $back );
        unset( $_SESSION['__back_to_url__'] );
        die();

    }

    // ...
    if( isset( $_REQUEST['b'] ) ) {

        $backDecoded = trim( $_REQUEST['b'] );
        $backToURL = decryptString( $backDecoded, $cf['auth']['gimbe']['key'] );
        $arrayBack = unserialize( $backToURL );

        if( is_array( $arrayBack ) ) {

            if( isset( $arrayBack['dstUrl'] ) ) {

                $_SESSION['__back_to_url__'] = $arrayBack['dstUrl'];

                if( isset( $cf['session']['account']['username'] ) ) {

                    $ct['etc']['__back_to_url__'] = $_SESSION['__back_to_url__'];
                    $ct['etc']['__back_to_url__'] .= ( parse_url( $_SESSION['__back_to_url__'], PHP_URL_QUERY ) ? '&' : '?' ) . 'j=' . $cf['session']['jwt']['string'];

                    header( 'location: ' . $ct['etc']['__back_to_url__'] );
                    unset( $_SESSION['__back_to_url__'] );

                }

            }

        }

    }

    /**
     * debug del runlevel
     * ==================
     * 
     * 
     */

    // debug
    // print_r( $cf['localization']['language'] );
    // die( print_r( $_REQUEST, true ) );
