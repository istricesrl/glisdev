--
-- TABELLE
-- =======
-- questo file contiene le query per la creazione delle tabelle; si noti che non devono essere inseriti qui i valori
-- di auto increment, mentre vanno specificati per tabella il CHARSET ma non il COLLATE.
--
-- LEGENDA DEI COMMENTI ALLE TABELLE
-- =================================
-- in questa sezione viene fornita una semplice legenda per interpretare i commenti che si trovano prima di ogni tabella.
--
-- funzionamento del sistema di patch
-- ----------------------------------
-- ogni tabella ha un ID univoco di 12 caratteri che la identifica e la posiziona all'interno del sistema di patch del
-- database del framework; le prime due cifre indicano la tipologia di patch:
--
-- 01xxxxxxxxxx -> tabelle
-- 02xxxxxxxxxx -> placeholder
-- 03xxxxxxxxxx -> indici
-- 04xxxxxxxxxx -> acl
-- 05xxxxxxxxxx -> dati
-- 06xxxxxxxxxx -> limiti
-- 07xxxxxxxxxx -> procedure
-- 08xxxxxxxxxx -> viste
-- 09xxxxxxxxxx -> report
-- 10xxxxxxxxxx -> statiche
-- 11xxxxxxxxxx -> trigger
--
-- per maggiori informazioni sul funzionamento del sistema di patch si vedano i commenti al file /_src/_api/_task/_mysql.patch.php.
-- 
-- classificazione in base all'utilizzo da parte dell'utente
-- ---------------------------------------------------------
-- in base alle possibilità che l'utente ha di interagire con la tabella, questa può essere:
--
-- - gestita
-- - assistita
-- - standard
--
-- le tabelle gestite partono vuote e il loro contenuto può essere gestito tramite l'interfaccia del CMS; le tabelle
-- assistite partono con dei dati di default ma il loro contenuto può essere comunque gestito tramite l'interfaccia del CMS;
-- infine le tabelle standard contengono dati fissi che non possono essere modificati tramite l'interfaccia del CMS.
--
-- classificazione in base alla gerarchia dei dati (rango)
-- -------------------------------------------------------
-- le tabelle possono contenere dati di vario rango, dove per rango si intende l'indipendenza dei dati stessi rispetto ad altri
-- contenuti in tabelle diverse; in base a questo criterio, le tabelle possono essere:
--
-- - principali
-- - secondarie
-- - di relazione
-- - di specifica
--
-- le tabelle principali contengono dati indipendenti, ossia che hanno senso in sé, indipendentemente da altri dati contenuti
-- in tabelle diverse; le tabelle principali, come anagrafica, gruppi, file, eccetera, rappresentano normalmente le entità del
-- framework.
--
-- le tabelle secondarie contengono dati che dipendono da una tabella principale, e che quindi non hanno senso in sé; ad esempio
-- la tabella telefoni dipende dalla tabella anagrafica, e un numero di telefono non collegato a una persona non ha senso di
-- esistere in sé.
--
-- le tabelle di relazione collegano fra loro due entità principali o secondarie, dunque hanno senso solo in funzione dell'esistenza
-- delle entità che collegano, e dell'esistenza del collegamento stesso; ad esempio la tabella account_gruppi collega gli account ai gruppi,
-- e i dati che contiene cessano di avere senso quando il gruppo o l'account collegati non esistono più.
--
-- le tabelle di specifica contengono dati che specificano o dettagliano i dati di una tabella principale o secondaria, e che quindi
-- hanno senso nella misura in cui sono applicati alle relative entità; ad esempio la tabella tipologie_anagrafica specifica la
-- tipologia di un'anagrafica.
--
-- classificazione in base alla struttura della tabella
-- ----------------------------------------------------
-- questa classificazione riguarda la struttura della tabella relativamente alle colonne che la compongono e ai relativi tipi di dato,
-- nonché alle relazioni che la tabella stabilisce con sé stessa e con altre tabelle; da questo punto di vista, le tabelle possono essere:
--
-- - base
-- - ricorsive
--
-- le tabelle base sono tabelle che non presentano particolari caratteristiche strutturali, e sono tipicamente costruite a partire da
-- un campo ID intero auto incrementale che funge da chiave primaria. Solitamente una tabella base presenta al minimo i seguenti campi:
--
-- - id
-- - id_tipologia
-- - nome
-- - note
-- - id_account_inserimento
-- - timestamp_inserimento
-- - id_account_aggiornamento
-- - timestamp_aggiornamento
--
-- le tabelle ricorsive sono tabelle che presentano una relazione con sé stesse, tipicamente tramite un campo id_genitore che fa riferimento
-- al campo id della stessa tabella; in questo modo si possono creare strutture ad albero, molto potenti e flessibili; tuttavia questo
-- approccio espone il database al rischio di creare cicli infiniti, e pertanto va usato con cautela. Solitamente le tabelle ricorsive
-- presentano oltre ai campi di minima visti sopra anche il campo id_genitore, posizionato subito dopo il campo id.
--
-- TODO
-- ====
-- in futuro ragionare se aggiungere le colonne id_gruppo_inserimento e id_gruppo_aggiornamento per tenere traccia del gruppo che ha
-- inserito o aggiornato la riga e anche per implementare un sistema di permessi più stile Linux rispetto a quello attuale delle ACL
-- 

-- | 010000001000

-- account
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene gli account degli utenti
-- entità: questa tabella corrisponde all'entità account
--
-- il framework supporta diverse modalità di accesso, tra cui l'accesso tramite account registrati nel
-- database e gestiti tramite CMS; i dettagli degli account non vengono letti tutti, ma solo quelli
-- relativi all'account corrente al momento del login
--
CREATE TABLE IF NOT EXISTS `account` (                        -- 
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica dell'utente cui appartiene l'account
  `id_mail` int(11) DEFAULT NULL,                             -- chiave esterna per la mail collegata all'account
  `id_affiliazione` int(11) DEFAULT NULL,                     -- chiave esterna (contratti) che associa un dato account a un contratto di affiliazione
  `id_url` int(11) DEFAULT NULL,                              -- chiave esterna (url) che associa un dato account a un URL
  `username` char(64) DEFAULT NULL,                           -- nome utente per il login
  `password` char(128) DEFAULT NULL,                          -- password (hash) per il login
  `se_attivo` tinyint(1) DEFAULT NULL,                        -- flag che indica se l'account è attivo o meno
  `token` char(128) DEFAULT NULL,                             -- token per il recupero password
  `timestamp_login` int(11) DEFAULT NULL,                     -- timestamp dell'ultimo login
  `timestamp_cambio_password` int(11) DEFAULT NULL,           -- timestamp dell'ultimo cambio password
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'account
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'account
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- NOTA la timestamp di cambio password non viene attualmente utilizzata ma è stata mantenuta per eventuali sviluppi futuri
--
-- TODO l'hash md5 non è il massimo, in futuro migrare a un algoritmo più robusto

-- | 010000001200

-- account_gruppi
-- tipologia: tabella gestita
-- rango: tabella di relazione
-- struttura: tabella base
-- funzioni: associa molti a molti gli account ai gruppi
--
-- questa tabella contiene le associazioni molti a molti tra gli account e i gruppi
--
CREATE TABLE IF NOT EXISTS `account_gruppi` (                 --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_account` int(11) DEFAULT NULL,                          -- chiave esterna per l'account
  `id_gruppo` int(11) DEFAULT NULL,                           -- chiave esterna per il gruppo
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `se_amministratore` tinyint(1) DEFAULT NULL,                -- flag per indicare se l'account è amministratore del gruppo associato
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'associazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'associazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;                       --

-- | 010000001300

-- account_gruppi_attribuzione
-- tipologia: tabella gestita
-- rango: tabella di relazione
-- struttura: tabella base
-- funzione: le righe di questa tabella innescano una logica applicativa di associazione fra un account, un gruppo e un'entità data
--
-- per vari casi d'uso può essere necessario che una riga creata da un determinato account venga automaticamente associata a un
-- altro gruppo su una tabella di ACL; ad esempio un account membro del gruppo commerciale italia potrebbe creare un cliente che deve
-- essere associato anche al gruppo commerciale mondo del quale l'account non fa parte (ad esempio per motivi di controllo)
--
CREATE TABLE IF NOT EXISTS `account_gruppi_attribuzione` (    --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_account` int(11) DEFAULT NULL,                          -- chiave esterna per l'account
  `id_gruppo` int(11) DEFAULT NULL,                           -- chiave esterna per il gruppo
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `entita` char(64) DEFAULT NULL,                             -- entità per la quale si innesca l'associazione
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'associazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'associazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- TODO documentare meglio questa tabella con riferimenti al codice
--

-- | 010000006000

-- consensi
-- tipologia: tabella assistita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i consensi per i trattamenti dati attivi nel sistema
-- entità: questa tabella corrisponde all'entità consensi
--
-- questa tabella contiene i consensi per i trattamenti dati attivi nel sistema, con le informazioni relative al nome del consenso
-- e alle note
--
CREATE TABLE IF NOT EXISTS `consensi` (                       --
  `id` char(64) NOT NULL,                                     -- chiave primaria
  `nome` char(255) DEFAULT NULL,                              -- nome del consenso
  `note` text DEFAULT NULL,                                   -- note sul consenso
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il consenso
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il consenso
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- TODO documentare meglio questa tabella con riferimenti al codice
--

-- | 010000006500

-- consensi_moduli
-- tipologia: tabella assistita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: specifica quali consensi vanno chiesti per ogni modulo attivo nel sistema
-- 
-- questa tabella contiene i consensi che vanno chiesti per ogni modulo attivo nel sistema, e va a integrare le informazioni già
-- presenti nei file di configurazione; questo viene effettuato nel file _src/_config/_180.privacy.php al quale si rimanda per
-- ulteriori approfondimenti
--
CREATE TABLE `consensi_moduli` (                              --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_lingua` int(11) DEFAULT NULL,                           -- chiave esterna per la lingua
  `id_consenso` char(64) DEFAULT NULL,                        -- chiave esterna per il consenso
  `modulo` char(32) DEFAULT NULL,                             -- ID del modulo cui si riferisce il consenso
  `ordine` int(11) DEFAULT NULL,                              -- campo di ordinamento
  `azione` char(32) DEFAULT NULL,                             -- etichetta per l'azione che l'utente deve compiere per accettare il consenso
  `nome` char(128) DEFAULT NULL,                              -- nome del consenso
  `informativa` char(128) DEFAULT NULL,                       -- testo per il link alla pagina che contiene l'informativa relativa al consenso, se presente
  `note` text DEFAULT NULL,                                   -- note sul consenso
  `pagina` char(32) DEFAULT NULL,                             -- ID della pagina che contiene l'informativa relativa al consenso, se presente
  `se_richiesto` tinyint(1) DEFAULT NULL,                     -- flag che indica se il consenso è richiesto
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il consenso
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il consenso
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000015000

-- file
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i file caricati nel sistema
-- 
-- questa tabella contiene i file caricati nel sistema, con le informazioni relative al percorso, al nome e alle
-- entità a cui sono associati
--
CREATE TABLE IF NOT EXISTS `file` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `id_ruolo` int(11) DEFAULT NULL,                            -- chiave esterna per il ruolo del file
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica a cui è associato il file
  `id_anagrafica_certificazioni` int(11) DEFAULT NULL,        -- chiave esterna per l'anagrafica certificazioni a cui è associato il file
  `id_prodotto` char(32) DEFAULT NULL,                        -- chiave esterna per il prodotto a cui è associato il file
  `id_articolo` char(32) DEFAULT NULL,                        -- chiave esterna per l'articolo a cui è associato il file
  `id_categoria_prodotti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di prodotti a cui è associato il file
  `id_todo` int(11) DEFAULT NULL,                             -- chiave esterna per la todo a cui è associato il file
  `id_pagina` int(11) DEFAULT NULL,                           -- chiave esterna per la pagina a cui è associato il file
  `id_template` int(11) DEFAULT NULL,                         -- chiave esterna per il template a cui è associato il file
  `id_mailing` int(11) DEFAULT NULL,                          -- chiave esterna per la mailing a cui è associato il file
  `id_notizia` int(11) DEFAULT NULL,                          -- chiave esterna per la notizia a cui è associato il file
  `id_categoria_notizie` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di notizie a cui è associato il file
  `id_annuncio` int(11) DEFAULT NULL,                         -- chiave esterna per l'annuncio a cui è associato il file
  `id_categoria_annunci` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di annunci a cui è associato il file
  `id_risorsa` int(11) DEFAULT NULL,                          -- chiave esterna per la risorsa a cui è associato il file
  `id_categoria_risorse` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di risorse a cui è associato il file
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto a cui è associato il file
  `id_categoria_progetti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di progetti a cui è associato il file
  `id_documento` int(11) DEFAULT NULL,                        -- chiave esterna per il documento a cui è associato il file
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo a cui è associato il file
  `id_edificio` int(11) DEFAULT NULL,                         -- chiave esterna per l'edificio a cui è associato il file
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile a cui è associato il file
  `id_contratto` int(11) DEFAULT NULL,                        -- chiave esterna per il contratto a cui è associato il file
  `id_rinnovo` int(11) DEFAULT NULL,                          -- chiave esterna per il rinnovo a cui è associato il file
  `id_valutazione` int(11) DEFAULT NULL,                      -- chiave esterna per la valutazione a cui è associato il file
  `id_valutazione_certificazioni` int(11) DEFAULT NULL,       -- chiave esterna per la valutazione certificazioni a cui è associato il file
  `id_mail_out` int(11) DEFAULT NULL,                         -- chiave esterna per la mail in uscita a cui è associato il file
  `id_mail_sent` int(11) DEFAULT NULL,                        -- chiave esterna per la mail inviata a cui è associato il file
  `id_licenza` int(11) DEFAULT NULL,                          -- chiave esterna per la licenza a cui è associato il file
  `id_attivita` int(11) DEFAULT NULL,                         -- chiave esterna per l'attività a cui è associato il file
  `id_lingua` int(11) DEFAULT NULL,                           -- chiave esterna per la lingua del file
  `nome` char(255) DEFAULT NULL,                              -- nome del file
  `path` char(255) DEFAULT NULL,                              -- percorso del file
  `url` char(255) DEFAULT NULL,                               -- URL del file
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il file
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il file
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000015200

-- gruppi
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene i gruppi del framework
--
-- questa tabella contiene i gruppi degli utenti del framework, ed è in relazione molti a molti con la tabella account
-- tramite la tabella di relazione account_gruppi
--
CREATE TABLE IF NOT EXISTS `gruppi` (                         --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna ricorsiva per il gruppo genitore
  `id_organizzazione` int(11) DEFAULT NULL,                   -- chiave esterna per l'organizzazione a cui appartiene il gruppo
  `nome` char(32) DEFAULT NULL,                               -- nome del gruppo
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il gruppo
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il gruppo
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000015600

-- immagini
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene le immagini caricate nel sistema
-- 
-- questa tabella contiene le immagini caricate nel sistema, con le informazioni relative al percorso, al nome e alle
-- entità a cui sono associate
--
CREATE TABLE IF NOT EXISTS `immagini` (                       --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `id_ruolo` int(11) DEFAULT NULL,                            -- chiave esterna per il ruolo dell'immagine
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica a cui è associata l'immagine
  `id_prodotto` char(32) DEFAULT NULL,                        -- chiave esterna per il prodotto a cui è associata l'immagine
  `id_articolo` char(32) DEFAULT NULL,                        -- chiave esterna per l'articolo a cui è associata l'immagine
  `id_categoria_prodotti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di prodotti a cui è associata l'immagine
  `id_pagina` int(11) DEFAULT NULL,                           -- chiave esterna per la pagina a cui è associata l'immagine
  `id_notizia` int(11) DEFAULT NULL,                          -- chiave esterna per la notizia a cui è associata l'immagine
  `id_categoria_notizie` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di notizie a cui è associata l'immagine
  `id_annuncio` int(11) DEFAULT NULL,                         -- chiave esterna per l'annuncio a cui è associata l'immagine
  `id_categoria_annunci` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di annunci a cui è associata l'immagine
  `id_risorsa` int(11) DEFAULT NULL,                          -- chiave esterna per la risorsa a cui è associata l'immagine
  `id_categoria_risorse` int(11) DEFAULT NULL,                -- chiave esterna per la categoria di risorse a cui è associata l'immagine
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto a cui è associata l'immagine
  `id_categoria_progetti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di progetti a cui è associata l'immagine
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo a cui è associata l'immagine
  `id_edificio` int(11) DEFAULT NULL,                         -- chiave esterna per l'edificio a cui è associata l'immagine
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile a cui è associata l'immagine
  `id_contratto` int(11) DEFAULT NULL,                        -- chiave esterna per il contratto a cui è associata l'immagine
  `id_rinnovo` int(11) DEFAULT NULL,                          -- chiave esterna per il rinnovo a cui è associata l'immagine
  `id_valutazione` int(11) DEFAULT NULL,                      -- chiave esterna per la valutazione a cui è associata l'immagine
  `id_file` int(11) DEFAULT NULL,                             -- chiave esterna per il file a cui è associata l'immagine
  `id_banner` int(11) DEFAULT NULL,                           -- chiave esterna per il banner a cui è associata l'immagine
  `id_lingua` int(11) DEFAULT NULL,                           -- chiave esterna per la lingua dell'immagine
  `nome` char(255) DEFAULT NULL,                              -- nome dell'immagine
  `orientamento` enum('L','P','S') DEFAULT NULL,              -- orientamento dell'immagine: L=landscape, P=portrait, S=square
  `taglio` char(64) DEFAULT NULL,                             -- taglio dell'immagine
  `path` char(255) DEFAULT NULL,                              -- percorso dell'immagine
  `path_alternativo` char(255) DEFAULT NULL,                  -- percorso alternativo dell'immagine
  `token` char(128) DEFAULT NULL,                             -- token per il lock dell'immagine
  `timestamp_scalamento` int(11) DEFAULT NULL,                -- timestamp dell'ultimo scalamento
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'immagine
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'immagine
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000016200

-- job
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i job di sistema
--
-- questa tabella contiene i job di sistema, per maggiori informazioni si veda la documentazione relativa ai file
-- /_src/_api/_cron.php e /_src/_api/_job.php
-- 
CREATE TABLE IF NOT EXISTS `job` (                            --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `nome` char(255) DEFAULT NULL,                              -- nome del job
  `job` char(255) NOT NULL,                                   -- percorso del file del job
  `timestamp_apertura` int(11) DEFAULT NULL,                  -- timestamp di apertura del job
  `totale` int(11) DEFAULT NULL,                              -- totale elementi da processare
  `corrente` int(11) DEFAULT NULL,                            -- elemento corrente
  `iterazioni` int(11) DEFAULT NULL,                          -- numero di iterazioni per ogni esecuzione del job
  `delay` int(11) DEFAULT NULL,                               -- delay in secondi tra un'esecuzione e l'altra del job
  `workspace` longtext DEFAULT NULL,                          -- workspace JSON del job
  `se_foreground` tinyint(1) DEFAULT NULL,                    -- flag che indica se il job è in foreground
  `token` char(254) DEFAULT NULL,                             -- token di lock del job
  `timestamp_esecuzione` int(11) DEFAULT NULL,                -- timestamp dell'ultima esecuzione del job
  `timestamp_completamento` int(11) DEFAULT NULL,             -- timestamp del completamento del job
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il job
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il job
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000016000

-- lingue
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene le lingue del sistema
-- entità: questa tabella corrisponde all'entità lingue
-- 
-- questa tabella contiene le lingue del sistema, con i relativi codici ISO e IETF
-- 
CREATE TABLE IF NOT EXISTS `lingue` (                         --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `nome` char(128) DEFAULT NULL,                              -- nome della lingua  
  `note` char(128) DEFAULT NULL,                              -- note sulla lingua (nome esteso, paese, eccetera)
  `iso6391alpha2` char(36) DEFAULT NULL,                      -- codice ISO 639-1 alpha-2 della lingua
  `iso6393alpha3` char(36) DEFAULT NULL,                      -- codice ISO 639-3 alpha-3 della lingua
  `ietf` char(36) DEFAULT NULL                                -- codice IETF della lingua
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000029000

-- redirect
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i redirect del sistema
-- entità: questa tabella corrisponde all'entità redirect
--
-- questa tabella contiene i redirect del sistema, con le informazioni relative al codice di stato HTTP, alla
-- sorgente e alla destinazione; per ulteriori informazioni sul funzionamento dei redirect nel framework si vedano
-- il codice e i commenti dei file _src/_config/_130.redirect.php e _src/_config/_135.redirect.php
--
CREATE TABLE IF NOT EXISTS `redirect` (                       --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_sito` int(11) DEFAULT NULL,                             -- ID del sito al quale appartiene il redirect
  `codice_stato_http` int(11) DEFAULT NULL,                   -- codice di stato HTTP del redirect
  `sorgente` char(255) DEFAULT NULL,                          -- sorgente del redirect
  `destinazione` char(255) DEFAULT NULL,                      -- destinazione del redirect
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il redirect
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il redirect
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000043000

-- task
-- tipologia: tabella assistita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i task pianificati del sistema
--
-- questa tabella contiene i task pianificati del sistema, per maggiori informazioni si veda la documentazione relativa ai file
-- /_src/_api/_cron.php e /_src/_api/_job.php
-- 
CREATE TABLE IF NOT EXISTS `task` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `minuto` int(11) DEFAULT NULL,                              -- minuto di esecuzione (0-59, NULL sta per ogni minuto)
  `ora` int(11) DEFAULT NULL,                                 -- ora di esecuzione (0-23, NULL sta per ogni ora)
  `giorno_del_mese` int(11) DEFAULT NULL,                     -- giorno del mese di esecuzione (1-31, NULL sta per ogni giorno del mese)
  `mese` int(11) DEFAULT NULL,                                -- mese di esecuzione (1-12, NULL sta per ogni mese)
  `giorno_della_settimana` int(11) DEFAULT NULL,              -- giorno della settimana di esecuzione (0-6, NULL sta per ogni giorno della settimana)
  `settimana` int(11) DEFAULT NULL,                           -- settimana di esecuzione (1-53, NULL sta per ogni settimana)
  `task` char(255) DEFAULT NULL,                              -- percorso del file del task
  `iterazioni` int(11) DEFAULT NULL,                          -- numero di iterazioni del task per ogni esecuzione
  `delay` int(11) DEFAULT NULL,                               -- delay in secondi tra un'esecuzione e l'altra del task
  `token` char(254) DEFAULT NULL,                             -- token di lock del task
  `timestamp_esecuzione` int(11) DEFAULT NULL,                -- timestamp dell'ultima esecuzione del task
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il task
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il task
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --


-- | 010000044000

-- template
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i template per le comunicazioni automatiche
--
-- questa tabella contiene i template per mail e sms
-- 
CREATE TABLE IF NOT EXISTS `template` (                       --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `nome` char(128) DEFAULT NULL,                              -- nome del template
  `ruolo` char(32) DEFAULT NULL,                              -- ruolo del template
  `tipo` char(32) DEFAULT NULL,                               -- tipo di template
  `note` text DEFAULT NULL,                                   -- note sul template
  `latenza_invio` int(11) DEFAULT NULL,                       -- latenza in secondi per l'invio del template
  `se_mail` tinyint(1) DEFAULT NULL,                          -- flag che indica se il template è per le mail
  `se_sms` tinyint(1) DEFAULT NULL,                           -- flag che indica se il template è per gli SMS
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il template
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il template
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000999000

-- test
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: test del database
-- entità: questa tabella corrisponde all'entità test
--
-- questa tabella viene utilizzata per testare la creazione di tabelle e la loro struttura; non è una tabella di produzione
--
CREATE TABLE IF NOT EXISTS `test` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `codice` char(32) DEFAULT NULL,                             -- codice univoco
  `nome` char(255) DEFAULT NULL                               -- dato di test
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | FINE FILE
