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

