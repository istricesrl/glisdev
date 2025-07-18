<?php

    /**
     * dichiarazione dei siti gestiti
     *
     * in questo file vengono dichiarati i siti gestiti dall'installazione corrente del framework
     *
     * il concetto di sito e l'approccio multisito
     * ===========================================
     * Una sola installazione fisica del framework è in grado di gestire più siti, intesi come diversi insiemi
     * di pagine, configurazioni e risorse multimediali. Questo risulta particolarmente comodo quando si devono
     * creare e gestire gruppi di siti fortemente interconnessi, magari con contenuti condivisi fra essi.
     *
     * In uno scenario multisito è possibile gestire, ad esempio, tutti i siti da un solo pannello di controllo,
     * il che rappresenta di per sé già una notevole comodità. Tutti i siti attivi nell'installazione corrente
     * sono definiti come sotto array dell'array $cf['sites'] e sono identificati da un ID che è anche la
     * chiave di $cf['sites'].
     *
     * struttura dell'array sito
     * -------------------------
     * Ogni sotto array di $cf['sites'] rappresenta un sito gestito dalla piattaforma, e come tale possiede
     * chiavi e sotto array che lo definiscono. Per una trattazione completa della struttura del sotto array sito
     * si rimanda alla \ref variabili "pagina del manuale che tratta le variabili del framework". In questa sede
     * è sufficiente evidenziare il ruolo svolto da $cf['sites']. L'installazione base del framework prevede
     * un solo sito, di default, a scopo principalmente dimostrativo; volendo utilizzare GlisWeb come piattaforma
     * per pubblicare contenuti sul web, la prima cosa da fare dovrebbe essere personalizzare in custom
     * (src/config/010.site.php) il sito di default.
     *
     * installazione del framework in una sottocartella
     * ------------------------------------------------
     * La variabile $cf['site']['basefolders'] consente alla piattaforma di essere
     * installata anche in una sottocartella della root del sito senza che si verifichino
     * problemi. In altre parole la piattaforma GlisWeb non necessita di essere collocata
     * nella radice dello spazio web per funzionare, ma può lavorare anche in una
     * sottocartella come ad esempio <protocollo>://<url>/[path/].
     *
     * lingue disponibili per il sito
     * ------------------------------
     * Il framework ricava le lingue disponibili dalle chiavi dell'array $cf['site']['name'];
     * in pratica, se si dà un nome al sito in una lingua, il framework suppone che si desideri
     * rendere l'intero sito disponibile in quella lingua. Pertanto nella redazione del file
     * scr/config/010.site.php si presti particolare attenzione a questo aspetto; inoltre,
     * visto che il framework prevede già un titolo di default per l'italiano è importante
     * sovrascriverlo oppure, se non si desidera rendere il sito disponibile in italiano,
     * eliminarlo tramite la funzione unset.
     *
     * host e dominio del sito
     * -----------------------
     * Assegnando a un sito un nome host e un dominio consentiamo al framework di capire, in base alla
     * richiesta HTTP che riceve, quale sito deve utilizzare. Il processo di riconoscimento del sito
     * attivo in base a host e dominio è effettuata nel successivo runlevel 015.
     *
     * alias di host e di dominio
     * --------------------------
     * Se necessario è possibile attribuire a un sito degli alias sia dell'host che del dominio; questi
     * concorreranno all'individuazione del sito corrente al runlevel 015 assieme all'host e al dominio
     * base. Si noti che non è necessario specificare un alias per la versione con e senza www del sito
     * in quanto il sistema gestisce già questo specifico aspetto automaticamente.
     *
     * configurazioni specifiche per sito
     * ----------------------------------
     * Una caratteristica molto importante del framework GlisWeb è la possibilità di specificare configurazioni
     * relative a un sito in particolare, che si sovrappongono alle configurazioni globali; i rami dell'array
     * $cf che sono soggetti a questo tipo di personalizzazione sono:
     *
     * - $cf['site'] al runlevel 025
     * - $cf['privacy'] al runlevel 065
     * - $cf['google'] al runlevel 115
     * - $cf['contents'] al runlevel 310
     * - $cf['smtp'] al runlevel 515
     * - $cf['slack'] al runlevel 555
     * - $cf['archivium'] al runlevel 565
     * - $cf['ftp'] al runlevel 585
     * 
     * la pagina home del sito
     * -----------------------
     * La dichiarazione della pagina home è fondamentale in quanto consente al framework di erogare una pagina
     * quando nessuna pagina viene specificata. Si può dire che la home page sia la pagina di default del sito.
     *
     */

    // debug
    // ini_set( 'display_errors', 1 );
    // ini_set( 'display_startup_errors', 1 );
    // error_reporting( E_ALL );

    /**
     * configurazione del sito di default
     * ==================================
     * Per funzionare il framework ha bisogno che sia definito almeno un sito; questa configurazione minimale mette
     * il deploy corrente in condizione di essere utilizzato. Tipicamente si vorrà personalizzare questa configurazione
     * con i dati specifici del proprio deploy.
     * 
     */

    // l'etichetta del sito
    $cf['sites']['1']['__label__']                              = 'default';

    // il titolo del sito
    $cf['sites']['1']['name']['it-IT']                          = NULL;

    // i protocolli del sito
    $cf['sites']['1']['protocols'][ DEVELOPEMENT ]              =
    $cf['sites']['1']['protocols'][ TESTING ]                   =
    $cf['sites']['1']['protocols'][ PRODUCTION ]                = 'http';

    // gli host del sito
    $cf['sites']['1']['hosts'][ DEVELOPEMENT ]                  =
    $cf['sites']['1']['hosts'][ TESTING ]                       =
    $cf['sites']['1']['hosts'][ PRODUCTION ]                    = $_SERVER['HTTP_HOST'];

    // i domini del sito
    $cf['sites']['1']['domains'][ DEVELOPEMENT ]                =
    $cf['sites']['1']['domains'][ TESTING ]                     =
    $cf['sites']['1']['domains'][ PRODUCTION ]                  = NULL;

    // gli alias degli host del sito
    $cf['sites']['1']['alias']['hosts'][ DEVELOPEMENT ]         =
    $cf['sites']['1']['alias']['hosts'][ TESTING ]              =
    $cf['sites']['1']['alias']['hosts'][ PRODUCTION ]           = array();

    // gli alias dei domini del sito
    $cf['sites']['1']['alias']['domains'][ DEVELOPEMENT ]       =
    $cf['sites']['1']['alias']['domains'][ TESTING ]            =
    $cf['sites']['1']['alias']['domains'][ PRODUCTION ]         = array();

    // le cartelle base del sito
    $cf['sites']['1']['folders'][ DEVELOPEMENT ]                =
    $cf['sites']['1']['folders'][ TESTING ]                     =
    $cf['sites']['1']['folders'][ PRODUCTION ]                  = NULL;

    // id pagina home
    $cf['sites']['1']['homes'][ DEVELOPEMENT ]                  =
    $cf['sites']['1']['homes'][ TESTING ]                       =
    $cf['sites']['1']['homes'][ PRODUCTION ]                    = NULL;

    /**
     * debug del runlevel
     * ==================
     * Questa sezione contiene alcune righe commentate utili per il debug del runlevel.
     * 
     */

    // debug
    // echo 'OUTPUT';
    // die( print_r( $cf['sites'], true ) );
