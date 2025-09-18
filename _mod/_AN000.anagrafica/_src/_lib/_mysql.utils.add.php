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

    /**
     *
     * TODO documentare
     * 
     */
    function tendinaCategorieAnagrafica() {

        global $cf;

        return mysqlCachedQuery(
            $cf['memcache']['connection'],
            $cf['mysql']['connection'],
            'SELECT id, __label__ FROM categorie_anagrafica_view'
        );

    }

    /**
     *
     * TODO documentare
     * 
     */
    function tendinaIdAnagraficaCollaboratori() {

        global $cf;

        return mysqlCachedIndexedQuery(
            $cf['memcache']['index'],
            $cf['memcache']['connection'],
            $cf['mysql']['connection'], 
            'SELECT id, __label__ FROM anagrafica_view_static'
        );

    }