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

-- | 010000000100

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

-- | 010000000120

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

-- | 010000000130

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
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `id_account` int(11) DEFAULT NULL,                          -- chiave esterna per l'account
  `id_gruppo` int(11) DEFAULT NULL,                           -- chiave esterna per il gruppo
  `entita` char(64) DEFAULT NULL,                             -- entità per la quale si innesca l'associazione
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'associazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'associazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- TODO documentare meglio questa tabella con riferimenti al codice
--

-- | 010000000400

-- anagrafica
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene le anagrafiche di persone e aziende
-- 
-- questa tabella contiene le anagrafiche di persone e aziende, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `anagrafica` (                     --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di anagrafica
  `id_badge` int(11) DEFAULT NULL,                            -- chiave esterna per il badge associato all'anagrafica
  `codice` char(32) DEFAULT NULL,                             -- codice dell'anagrafica
  `riferimento` char(255) DEFAULT NULL,                       -- riferimento interno per l'anagrafica
  `nome` char(64) DEFAULT NULL,                               -- nome della persona
  `cognome` char(255) DEFAULT NULL,                           -- cognome della persona
  `denominazione` char(255) DEFAULT NULL,                     -- denominazione dell'azienda
  `soprannome` char(128) DEFAULT NULL,                        -- soprannome o nome commerciale
  `sesso` enum('M','F','-') DEFAULT NULL,                     -- sesso della persona
  `stato_civile` char(128) DEFAULT NULL,                      -- stato civile della persona
  `codice_fiscale` char(32) DEFAULT NULL,                     -- codice fiscale della persona o dell'azienda
  `partita_iva` char(32) DEFAULT NULL,                        -- partita IVA della persona o dell'azienda
  `codice_sdi` char(32) DEFAULT NULL,                         -- codice SDI per la fatturazione elettronica
  `id_pec_sdi` int(11) DEFAULT NULL,                          -- chiave esterna per la PEC associata al codice SDI
  `codice_ipa` char(32) DEFAULT NULL,                         -- codice IPA per la fatturazione elettronica verso la pubblica amministrazione
  `codice_archivium` char(16) DEFAULT NULL,                   -- codice per l'integrazione con Archivium
  `id_regime` int(11) DEFAULT NULL,                           -- chiave esterna per il regime fiscale
  `note_amministrative` text DEFAULT NULL,                    -- note amministrative
  `note_collaborazione` text DEFAULT NULL,                    -- note di collaborazione
  `luogo_nascita` char(128) DEFAULT NULL,                     -- luogo di nascita
  `stato_nascita` char(128) DEFAULT NULL,                     -- stato di nascita
  `id_stato_nascita` int(11) DEFAULT NULL,                    -- chiave esterna per lo stato di nascita
  `comune_nascita` char(128) DEFAULT NULL,                    -- comune di nascita
  `id_comune_nascita` int(11) DEFAULT NULL,                   -- chiave esterna per il comune di nascita
  `giorno_nascita` int(2) DEFAULT NULL,                       -- giorno di nascita
  `mese_nascita` int(2) DEFAULT NULL,                         -- mese di nascita
  `anno_nascita` int(4) DEFAULT NULL,                         -- anno di nascita
  `id_ranking` int(11) DEFAULT NULL,                          -- chiave esterna per il ranking
  `id_agente` int(11) DEFAULT NULL,                           -- chiave esterna per l'agente
  `id_responsabile_operativo` int(11) DEFAULT NULL,           -- chiave esterna per il responsabile operativo
  `note_commerciali` text DEFAULT NULL,                       -- note commerciali
  `condizioni_vendita` text DEFAULT NULL,                     -- condizioni di vendita
  `condizioni_acquisto` text DEFAULT NULL,                    -- condizioni di acquisto
  `note` text DEFAULT NULL,                                   -- note
  `data_archiviazione` date DEFAULT NULL,                     -- data di archiviazione
  `note_archiviazione` text DEFAULT NULL,                     -- note di archiviazione
  `recapiti` text DEFAULT NULL,                               -- recapiti
  `token` char(255) DEFAULT NULL,                             -- token
  `se_importata` tinyint(1) DEFAULT NULL,                     -- flag per importazione
  `se_stampa_privacy` tinyint(1) DEFAULT NULL,                -- flag per stampa privacy
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account di inserimento
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account di aggiornamento
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000000500

-- anagrafica_categorie
-- tipologia: tabella gestita
-- rango: tabella di relazione
-- struttura: tabella base
-- funzione: associa molti a molti le anagrafiche alle categorie
--
-- questa tabella contiene le associazioni molti a molti tra le anagrafiche e le categorie
-- 
CREATE TABLE IF NOT EXISTS `anagrafica_categorie` (           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica
  `id_categoria` int(11) DEFAULT NULL,                        -- chiave esterna per la categoria
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'associazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'associazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000000900

-- anagrafica_indirizzi
-- tipologia: tabella gestita
-- rango: tabella di relazione
-- struttura: tabella base
-- funzione: associa molti a molti le anagrafiche agli indirizzi
--
-- questa tabella contiene le associazioni molti a molti tra le anagrafiche e gli indirizzi
--
CREATE TABLE IF NOT EXISTS `anagrafica_indirizzi` (           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di indirizzo
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `codice` char(64) DEFAULT NULL,                             -- codice dell'indirizzo
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo
  `id_ruolo` int(11) DEFAULT NULL,                            -- chiave esterna per il ruolo dell'indirizzo
  `interno` char(8) DEFAULT NULL,                             -- interno dell'indirizzo
  `indirizzo` char(255) DEFAULT NULL,                         -- indirizzo
  `civico` char(16) DEFAULT NULL,                             -- civico dell'indirizzo
  `id_comune` int(11) DEFAULT NULL,                           -- chiave esterna per il comune
  `localita` char(128) DEFAULT NULL,                          -- località
  `cap` char(11) DEFAULT NULL,                                -- CAP
  `note` text DEFAULT NULL,                                   -- note sull'indirizzo
  `latitudine` decimal(11,7) DEFAULT NULL,                    -- latitudine
  `longitudine` decimal(11,7) DEFAULT NULL,                   -- longitudine
  `token` char(128) DEFAULT NULL,                             -- token per geolocalizzazione
  `timestamp_geolocalizzazione` int(11) DEFAULT NULL,         -- timestamp dell'ultima geolocalizzazione
  `timestamp_elaborazione` int(11) DEFAULT NULL,              -- timestamp dell'ultima elaborazione
  `note_elaborazione` text DEFAULT NULL,                      -- note sull'ultima elaborazione
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'associazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'associazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000001700

-- asset
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene gli asset (beni aziendali)
--
-- questa tabella contiene gli asset (beni aziendali) che possono essere collegati a molte altre entità del framework
--
CREATE TABLE IF NOT EXISTS `asset` (                            --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                          -- chiave esterna per la tipologia di asset
  `codice` int(11) DEFAULT NULL,                                -- codice dell'asset
  `nome` char(128) DEFAULT NULL,                                -- nome dell'asset
  `hostname` char(128) DEFAULT NULL,                            -- hostname dell'asset
  `ip_address` char(32) DEFAULT NULL,                           -- indirizzo IP dell'asset
  `cespite` char(32) DEFAULT NULL,                              -- codice cespite dell'asset
  `note` text DEFAULT NULL,                                     -- note sull'asset
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito l'asset
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato l'asset
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;                          --

-- | 010000001800

-- attivita
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le attività
--
-- questa tabella contiene le attività, che possono essere collegate a molte altre entità del framework
--
CREATE TABLE IF NOT EXISTS `attivita` (                       --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per l'attività genitore
  `codice` char(32) DEFAULT NULL,                             -- codice dell'attività
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di attività
  `id_cliente` int(11) DEFAULT NULL,                          -- chiave esterna per il cliente collegato all'attività
  `id_contatto` int(11) DEFAULT NULL,                         -- chiave esterna per il contatto collegato all'attività
  `referenti` char(255) DEFAULT NULL,                         -- referenti dell'attività
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo collegato all'attività
  `id_luogo` int(11) DEFAULT NULL,                            -- chiave esterna per il luogo collegato all'attività
  `id_messaggio` int(11) DEFAULT NULL,                        -- chiave esterna per il messaggio collegato all'attività
  `id_oggetto` int(11) DEFAULT NULL,                          -- chiave esterna per l'oggetto collegato all'attività
  `data_scadenza` date DEFAULT NULL,                          -- data di scadenza
  `ora_scadenza` time DEFAULT NULL,                           -- ora di scadenza
  `note_scadenza` text DEFAULT NULL,                          -- note sulla scadenza
  `data_programmazione` date DEFAULT NULL,                    -- data di programmazione
  `ora_inizio_programmazione` time DEFAULT NULL,              -- ora di inizio programmazione
  `ora_fine_programmazione` time DEFAULT NULL,                -- ora di fine programmazione
  `id_anagrafica_programmazione` int(11) DEFAULT NULL,        -- chiave esterna per l'anagrafica di programmazione
  `note_programmazione` text DEFAULT NULL,                    -- note sulla programmazione
  `ore_programmazione` decimal(5,2) DEFAULT NULL,             -- ore di programmazione
  `se_confermata` int(1) DEFAULT NULL,                        -- flag che indica se l'attività è confermata
  `data_attivita` date DEFAULT NULL,                          -- data dell'attività
  `ora_inizio` time DEFAULT NULL,                             -- ora di inizio dell'attività
  `latitudine_ora_inizio` decimal(11,7) DEFAULT NULL,         -- latitudine al momento dell'inizio dell'attività
  `longitudine_ora_inizio` decimal(11,7) DEFAULT NULL,        -- longitudine al momento dell'inizio dell'attività
  `data_fine` date DEFAULT NULL,                              -- data di fine dell'attività
  `ora_fine` time DEFAULT NULL,                               -- ora di fine dell'attività
  `latitudine_ora_fine` decimal(11,7) DEFAULT NULL,           -- latitudine al momento della fine dell'attività
  `longitudine_ora_fine` decimal(11,7) DEFAULT NULL,          -- longitudine al momento della fine dell'attività
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica collegata all'attività
  `id_account` int(11) DEFAULT NULL,                          -- chiave esterna per l'account collegato all'attività
  `id_asset` int(11) DEFAULT NULL,                            -- chiave esterna per l'asset collegato all'attività
  `ore` decimal(5,2) DEFAULT NULL,                            -- ore effettive dell'attività
  `nome` char(255) DEFAULT NULL,                              -- nome dell'attività
  `note` text DEFAULT NULL,                                   -- note sull'attività
  `note_cliente` text DEFAULT NULL,                           -- note per il cliente
  `id_mailing` int(11) DEFAULT NULL,                          -- chiave esterna per il mailing collegato all'attività
  `id_mail` int(11) DEFAULT NULL,                             -- chiave esterna per la mail collegata all'attività
  `id_documento` int(11) DEFAULT NULL,                        -- chiave esterna per il documento collegato all'attività
  `id_corrispondenza` int(11) DEFAULT NULL,                   -- chiave esterna per la corrispondenza collegata all'attività
  `id_pagamento` int(11) DEFAULT NULL,                        -- chiave esterna per il pagamento collegato all'attività
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto collegato all'attività
  `id_contratto` int(11) DEFAULT NULL,                        -- chiave esterna per il contratto collegato all'attività
  `id_matricola` int(11) DEFAULT NULL,                        -- chiave esterna per la matricola collegata all'attività
  `id_todo` int(11) DEFAULT NULL,                             -- chiave esterna per il todo collegato all'attività
  `id_mastro_provenienza` int(11) DEFAULT NULL,               -- chiave esterna per il mastro di provenienza
  `id_mastro_destinazione` int(11) DEFAULT NULL,              -- chiave esterna per il mastro di destinazione
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile collegato all'attività
  `id_step` int(11) DEFAULT NULL,                             -- chiave esterna per lo step collegato all'attività
  `id_pianificazione` int(11) DEFAULT NULL,                   -- chiave esterna per la pianificazione collegata all'attività
  `codice_archivium` char(32) DEFAULT NULL,                   -- codice per l'integrazione con Archivium
  `token` char(128) DEFAULT NULL,                             -- token per geolocalizzazione
  `timestamp_calcolo_sostituti` int(11) DEFAULT NULL,         -- timestamp dell'ultimo calcolo dei sostituti
  `timestamp_archiviazione` int(11) DEFAULT NULL,             -- timestamp di archiviazione
  `id_account_archiviazione` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha archiviato l'attività
  `note_archiviazione` text NULL,                             -- note di archiviazione
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'attività
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'attività
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000003100

-- categorie_anagrafica
-- tipologia: tabella assistita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le categorie delle anagrafiche
-- 
-- questa tabella contiene le categorie delle anagrafiche
-- 
CREATE TABLE IF NOT EXISTS `categorie_anagrafica` (           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la categoria genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `codice` char(32) DEFAULT NULL,                             -- codice della categoria
  `nome` char(64) DEFAULT NULL,                               -- nome della categoria
  `note` text DEFAULT NULL,                                   -- note sulla categoria
  `se_lead` tinyint(1) DEFAULT NULL,                          -- flag che indica se la categoria è un lead
  `se_prospect` tinyint(1) DEFAULT NULL,                      -- flag che indica se la categoria è un prospect
  `se_cliente` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è un cliente
  `se_fornitore` tinyint(1) DEFAULT NULL,                     -- flag che indica se la categoria è un fornitore
  `se_produttore` tinyint(1) DEFAULT NULL,                    -- flag che indica se la categoria è un produttore
  `se_collaboratore` tinyint(1) DEFAULT NULL,                 -- flag che indica se la categoria è un collaboratore
  `se_interno` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è un interno
  `se_esterno` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è un esterno
  `se_concorrente` tinyint(1) DEFAULT NULL,                   -- flag che indica se la categoria è un concorrente
  `se_gestita` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è gestita
  `se_amministrazione` tinyint(1) DEFAULT NULL,               -- flag che indica se la categoria è in amministrazione
  `se_produzione` tinyint(1) DEFAULT NULL,                    -- flag che indica se la categoria è in produzione
  `se_commerciale` tinyint(1) DEFAULT NULL,                   -- flag che indica se la categoria è nel commerciale
  `se_notizie` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è collegata alle notizie
  `se_corriere` tinyint(1) DEFAULT NULL,                      -- flag che indica se la categoria è un corriere
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la categoria
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la categoria
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000004300

-- categorie_progetti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le categorie dei progetti
--
-- questa tabella contiene le categorie dei progetti
--
CREATE TABLE IF NOT EXISTS `categorie_progetti` (             --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la categoria genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `codice` char(32) DEFAULT NULL,                             -- codice della categoria
  `nome` char(255) DEFAULT NULL,                              -- nome della categoria
  `note` text DEFAULT NULL,                                   -- note sulla categoria
  `template` char(255) DEFAULT NULL,                          -- template associato alla categoria
  `schema_html` char(128) DEFAULT NULL,                       -- schema HTML associato alla categoria
  `tema_css` char(128) DEFAULT NULL,                          -- tema CSS associato alla categoria
  `se_sitemap` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria deve essere inclusa nella sitemap
  `se_cacheable` tinyint(1) DEFAULT NULL,                     -- flag che indica se la categoria è cacheable
  `id_sito` int(11) DEFAULT NULL,                             -- chiave esterna per il sito di appartenenza
  `id_pagina` int(11) DEFAULT NULL,                           -- chiave esterna per la pagina di appartenenza
  `se_ordinario` tinyint(1) DEFAULT NULL,                     -- flag che indica se la categoria è ordinaria
  `se_straordinario` tinyint(1) DEFAULT NULL,                 -- flag che indica se la categoria è straordinaria
  `se_disciplina` tinyint(1) DEFAULT NULL,                    -- flag che indica se la categoria è disciplinare
  `se_classe` tinyint(1) DEFAULT NULL,                        -- flag che indica se la categoria è di classe
  `se_fascia` tinyint(1) DEFAULT NULL,                        -- flag che indica se la categoria è di fascia
  `se_periodo` tinyint(1) DEFAULT NULL,                       -- flag che indica se la categoria è di periodo
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la categoria
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la categoria
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000005300

-- comuni
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i comuni italiani
--
-- questa tabella contiene i comuni italiani, con le informazioni relative al nome, al codice ISTAT, al codice catastale,
-- all'ID della provincia di appartenenza, e ad un eventuale URL di riferimento
--
CREATE TABLE IF NOT EXISTS `comuni` (                         --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_provincia` int(11) DEFAULT NULL,                        -- chiave esterna per la provincia di appartenenza
  `nome` varchar(254) DEFAULT NULL,                           -- nome del comune
  `codice_istat` char(12) DEFAULT NULL,                       -- codice ISTAT del comune
  `codice_catasto` char(4) DEFAULT NULL,                      -- codice catastale del comune
  `url_riferimento` char(255) DEFAULT NULL,                   -- URL di riferimento del comune
  `note` text DEFAULT NULL                                    -- note sul comune
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

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

-- | 010000006700

-- contatti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i contatti acquisiti
--
-- questa tabella contiene i contatti acquisiti, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `contatti` (                       --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di contatto
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica collegata al contatto
  `id_inviante` int(11) DEFAULT NULL,                         -- chiave esterna per l'anagrafica dell'inviante
  `id_ranking` int(11) DEFAULT NULL,                          -- chiave esterna per il ranking
  `utm_id` char(128) DEFAULT NULL,                            -- UTM id
  `utm_source` char(128) DEFAULT NULL,                        -- UTM source
  `utm_medium` char(128) DEFAULT NULL,                        -- UTM medium
  `utm_campaign` char(128) DEFAULT NULL,                      -- UTM campaign
  `utm_term` char(128) DEFAULT NULL,                          -- UTM term
  `utm_content` char(128) DEFAULT NULL,                       -- UTM content
  `nome` char(255) DEFAULT NULL,                              -- nome del contatto
  `note` text DEFAULT NULL,                                   -- note sul contatto
  `json` text DEFAULT NULL,                                   -- campo JSON per informazioni aggiuntive
  `timestamp_contatto` int(11) DEFAULT NULL,                  -- timestamp del contatto
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il contatto
  `timestamp_aggiornamento` int(11) DEFAULT NULL,             -- timestamp di aggiornamento
  `id_account_aggiornamento` int(11) DEFAULT NULL             -- chiave esterna per l'account che ha aggiornato il contatto
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000007100

-- continenti
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i continenti
--
-- questa tabella contiene i continenti, con il loro codice e il loro nome
--
CREATE TABLE IF NOT EXISTS `continenti` (                     --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `codice` char(32) DEFAULT NULL,                             -- codice del continente
  `nome` char(32) DEFAULT NULL                                -- nome del continente
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000007200

-- contratti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i contratti di affiliazione
--
-- questa tabella contiene i contratti di affiliazione, con le informazioni principali
--
CREATE TABLE `contratti` (                                    --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di contratto
  `codice` char(32) DEFAULT NULL,                             -- codice del contratto
  `codice_affiliazione` char(32) DEFAULT NULL,                -- codice di affiliazione
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile associato al contratto
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto associato al contratto
  `id_categoria_progetti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di progetti associata al contratto
  `id_badge` int(11) DEFAULT NULL,                            -- chiave esterna per il badge associato al contratto
  `nome` char(128) DEFAULT NULL,                              -- nome del contratto
  `note` text DEFAULT NULL,                                   -- note sul contratto
  `note_cliente` text DEFAULT NULL,                           -- note per il cliente
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il contratto
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il contratto
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000007800

-- corrispondenza
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene la corrispondenza in uscita
--
-- questa tabella contiene la corrispondenza in uscita, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `corrispondenza` (                   --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                          -- chiave esterna per la tipologia di corrispondenza
  `codice` char(64) DEFAULT NULL,                               -- codice della corrispondenza
  `id_peso` int(11) DEFAULT NULL,                               -- chiave esterna per il peso
  `peso` decimal(5,2) DEFAULT NULL,                             -- peso della corrispondenza
  `id_formato` int(11) DEFAULT NULL,                            -- chiave esterna per il formato
  `id_distinta` int(11) DEFAULT NULL,                           -- chiave esterna per la distinta
  `quantita` int(11) DEFAULT NULL,                              -- quantità della corrispondenza
  `id_mittente` int(11) DEFAULT NULL,                           -- chiave esterna per l'anagrafica mittente
  `id_organizzazione_mittente` int(11) DEFAULT NULL,            -- chiave esterna per l'organizzazione mittente
  `id_commesso` int(11) DEFAULT NULL,                           -- chiave esterna per il commesso
  `nome` char(255) DEFAULT NULL,                                -- nome del mittente
  `destinatario_nome` char(155) DEFAULT NULL,                   -- nome del destinatario
  `destinatario_cognome` char(255) DEFAULT NULL,                -- cognome del destinatario
  `destinatario_denominazione` char(255) DEFAULT NULL,          -- denominazione del destinatario
  `destinatario_codice_fiscale` char(255) DEFAULT NULL,         -- codice fiscale del destinatario
  `destinatario_partita_iva` char(255) DEFAULT NULL,            -- partita IVA del destinatario
  `destinatario_id_tipologia_anagrafica` int(11) DEFAULT NULL,  -- chiave esterna per la tipologia di anagrafica del destinatario
  `destinatario_id_anagrafica` int(11) DEFAULT NULL,            -- chiave esterna per l'anagrafica del destinatario
  `destinatario_indirizzo` char(255) DEFAULT NULL,              -- indirizzo del destinatario
  `destinatario_civico` char(16) DEFAULT NULL,                  -- civico del destinatario
  `destinatario_cap` char(16) DEFAULT NULL,                     -- CAP del destinatario
  `destinatario_citta` char(255) DEFAULT NULL,                  -- città del destinatario
  `destinatario_id_comune` int(11) DEFAULT NULL,                -- chiave esterna per il comune del destinatario
  `destinatario_id_provincia` int(11) DEFAULT NULL,             -- chiave esterna per la provincia del destinatario
  `destinatario_id_stato` int(11) DEFAULT NULL,                 -- chiave esterna per lo stato del destinatario
  `id_tipologia_certificazione_consegna` int(11) DEFAULT NULL,  -- chiave esterna per la tipologia di certificazione di consegna
  `numero_certificazione_consegna` char(255) DEFAULT NULL,      -- numero della certificazione di consegna
  `id_tipologia_consegna` int(11) DEFAULT NULL,                 -- chiave esterna per la tipologia di consegna
  `nome_consegna` char(255) DEFAULT NULL,                       -- nome per la consegna
  `cognome_consegna` char(255) DEFAULT NULL,                    -- cognome per la consegna
  `timestamp_consegna` int(11) DEFAULT NULL,                    -- timestamp di consegna
  `requisiti_consegna` text DEFAULT NULL,                       -- requisiti per la consegna
  `note_consegna` text DEFAULT NULL,                            -- note sulla consegna
  `timestamp_elaborazione` int(11) DEFAULT NULL,                -- timestamp dell'ultima elaborazione
  `note_elaborazione` text DEFAULT NULL,                        -- note sull'ultima elaborazione
  `timestamp_gestione` int(11) DEFAULT NULL,                    -- timestamp dell'ultima gestione
  `note_gestione` text DEFAULT NULL,                            -- note sull'ultima gestione
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito la corrispondenza
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato la corrispondenza
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                           --

-- | 010000009800

-- documenti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i documenti emessi
--
-- questa tabella contiene i documenti emessi, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `documenti` (                      --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di documento
  `codice` char(32) DEFAULT NULL,                             -- codice del documento
  `numero` char(32) DEFAULT NULL,                             -- numero del documento
  `sezionale` char(32) DEFAULT NULL,                          -- sezionale del documento
  `data` date DEFAULT NULL,                                   -- data del documento
  `nome` char(255) DEFAULT NULL,                              -- nome del documento
  `id_emittente` int(11) DEFAULT NULL,                        -- chiave esterna per l'anagrafica emittente
  `id_referente_emittente` int(11) DEFAULT NULL,              -- chiave esterna per il referente dell'anagrafica emittente
  `id_sede_emittente` int(11) DEFAULT NULL,                   -- chiave esterna per la sede dell'anagrafica emittente
  `id_destinatario` int(11) DEFAULT NULL,                     -- chiave esterna per l'anagrafica destinataria
  `id_sede_destinatario` int(11) DEFAULT NULL,                -- chiave esterna per la sede dell'anagrafica destinataria
  `id_condizione_pagamento` int(11) DEFAULT NULL,             -- chiave esterna per la condizione di pagamento
  `esigibilita`	enum('I','D','S') DEFAULT NULL,               -- esigibilità del documento
  `codice_archivium` char(64) DEFAULT NULL ,                  -- codice per Archivium
  `codice_sdi` char(64) DEFAULT NULL,                         -- codice SDI per fatturazione elettronica
  `cig` char(16) DEFAULT NULL,                                -- codice CIG
  `cup` char(16) DEFAULT NULL,                                -- codice CUP
  `riferimento` char(255) DEFAULT NULL,                       -- riferimento del documento
  `timestamp_invio` int(11) DEFAULT NULL,                     -- timestamp di invio del documento
  `progressivo_invio` char(5) DEFAULT NULL,                   -- progressivo di invio del documento
  `id_coupon` char(32) DEFAULT NULL,                          -- chiave esterna per il coupon associato al documento
  `id_mastro_provenienza` int(11) DEFAULT NULL,               -- chiave esterna per il mastro di provenienza
  `id_mastro_destinazione` int(11) DEFAULT NULL,              -- chiave esterna per il mastro di destinazione
  `porto` enum('franco','assegnato','-') DEFAULT NULL,        -- modalità di consegna
  `id_causale` int(11) DEFAULT NULL,                          -- chiave esterna per la causale del documento
  `id_trasportatore` int(11) DEFAULT NULL,                    -- chiave esterna per l'anagrafica del trasportatore
  `id_carrello` int(11) DEFAULT NULL,                         -- chiave esterna per il carrello collegato al documento
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile collegato al documento
  `id_pianificazione` int(11) DEFAULT NULL,                   -- chiave esterna per la pianificazione collegata al documento
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto collegato al documento
  `xml` longtext DEFAULT NULL,                                -- contenuto XML per fatturazione elettronica
  `data_consegna` date DEFAULT NULL,                          -- data di consegna
  `note_consegna` text DEFAULT NULL,                          -- note sulla consegna
  `note` text DEFAULT NULL,                                   -- note sul documento
  `note_cliente` text DEFAULT NULL,                           -- note per il cliente
  `note_invio` text DEFAULT NULL,                             -- note per l'invio
  `timestamp_chiusura` int(11) DEFAULT NULL,                  -- timestamp di chiusura del documento
  `note_chiusura` text DEFAULT NULL,                          -- note per la chiusura del documento
  `token` char(128) DEFAULT NULL,                             -- token per la gestione del documento
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il documento
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento del documento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il documento
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento del documento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000010000

-- documenti_articoli
-- tipologia: tabella gestita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: contiene gli articoli associati ai documenti emessi
--
-- questa tabella contiene gli articoli associati ai documenti emessi, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `documenti_articoli` (               --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                           -- chiave esterna per l'articolo genitore (per articoli composti)
  `id_tipologia` int(11) DEFAULT NULL,                          -- chiave esterna per la tipologia di articolo
  `codice` char(32) DEFAULT NULL,                               -- codice dell'articolo
  `ordine` int(11) DEFAULT NULL,                                -- ordine di visualizzazione
  `id_documento` int(11) DEFAULT NULL,                          -- chiave esterna per il documento di appartenenza
  `data` date DEFAULT NULL,                                     -- data dell'articolo
  `id_missione`	int(11) DEFAULT NULL,                           -- chiave esterna per la missione collegata all'articolo
  `id_packing_list`	int(11) DEFAULT NULL,                       -- chiave esterna per la packing list collegata all'articolo
  `id_destinatario` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica destinataria
  `id_emittente` int(11) DEFAULT NULL,                          -- chiave esterna per l'anagrafica emittente
  `id_reparto` int(11) DEFAULT NULL,                            -- chiave esterna per il reparto collegato all'articolo
  `id_progetto` char(32) DEFAULT NULL,                          -- chiave esterna per il progetto collegato all'articolo
  `id_todo` int(11) DEFAULT NULL,                               -- chiave esterna per la todo collegata all'articolo
  `id_attivita` int(11) DEFAULT NULL,                           -- chiave esterna per l'attività collegata all'articolo
  `id_articolo` char(32) DEFAULT NULL,                          -- chiave esterna per l'articolo collegato
  `id_collo` int(11) DEFAULT NULL,                              -- chiave esterna per il collo collegato all'articolo
  `id_prodotto` char(32) DEFAULT NULL,                          -- chiave esterna per il prodotto collegato
  `id_mastro_provenienza` int(11) DEFAULT NULL,                 -- chiave esterna per il mastro di provenienza
  `id_mastro_destinazione` int(11) DEFAULT NULL,                -- chiave esterna per il mastro di destinazione
  `id_udm` int(11) DEFAULT NULL,                                -- chiave esterna per l'unità di misura
  `id_matricola` int(11) DEFAULT NULL,                          -- chiave esterna per la matricola collegata
  `id_rinnovo` int(11) DEFAULT NULL,                            -- chiave esterna per il rinnovo collegato
  `id_carrelli_articoli` int(11) DEFAULT NULL,                  -- chiave esterna per l'articolo del carrello collegato
  `quantita_prevista` decimal(9,2) DEFAULT NULL,                -- quantità prevista
  `quantita` decimal(9,2) DEFAULT NULL,                         -- quantità dell'articolo
  `id_listino` int(11) DEFAULT NULL,                            -- chiave esterna per il listino applicato
  `costo_netto_unitario` decimal(16,2) DEFAULT NULL,            -- costo netto unitario
  `costo_netto_totale` decimal(16,2) DEFAULT NULL,              -- costo netto totale
  `prezzo_netto_unitario` decimal(16,2) DEFAULT NULL,           -- prezzo netto unitario
  `prezzo_netto_totale` decimal(16,2) DEFAULT NULL,             -- prezzo netto totale
  `importo_netto_totale` decimal(16,2) DEFAULT NULL,            -- importo netto totale
  `importo_lordo_totale` decimal(16,2) DEFAULT NULL,            -- importo lordo totale
  `sconto_percentuale` decimal(9,2) DEFAULT NULL,               -- sconto percentuale
  `sconto_valore` decimal(9,2) DEFAULT NULL,                    -- sconto in valore assoluto
  `importo_lordo_finale` decimal(16,2) DEFAULT NULL,            -- importo lordo finale
  `nome` char(255) DEFAULT NULL,                                -- nome dell'articolo
  `specifiche` char(255) DEFAULT NULL,                          -- specifiche dell'articolo
  `note` text DEFAULT NULL,                                     -- note sull'articolo
  `data_consegna` date DEFAULT NULL,                            -- data di consegna
  `note_consegna` text DEFAULT NULL,                            -- note sulla consegna
  `id_pianificazione` int(11) DEFAULT NULL,                     -- chiave esterna per la pianificazione collegata all'articolo
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito l'articolo
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato l'articolo
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                           -- tabella articoli

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

-- | 010000015800

-- indirizzi
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene gli indirizzi
--
-- questa tabella contiene gli indirizzi, con le informazioni relative alla tipologia, al comune, alla località,
-- all'indirizzo, al civico, al CAP, alle note, alla latitudine e alla longitudine
--
CREATE TABLE IF NOT EXISTS `indirizzi` (                      --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia dell'indirizzo
  `id_comune` int(11) DEFAULT NULL,                           -- chiave esterna per il comune
  `localita` char(128) DEFAULT NULL,                          -- località
  `indirizzo` char(128) DEFAULT NULL,                         -- indirizzo
  `civico` char(16) DEFAULT NULL,                             -- civico
  `cap` char(11) DEFAULT NULL,                                -- CAP
  `note` text DEFAULT NULL,                                   -- note sull'indirizzo
  `latitudine` decimal(11,7) DEFAULT NULL,                    -- latitudine
  `longitudine` decimal(11,7) DEFAULT NULL,                   -- longitudine
  `token` char(128) DEFAULT NULL,                             -- token per il lock dell'indirizzo
  `timestamp_geolocalizzazione` int(11) DEFAULT NULL,         -- timestamp dell'ultima geolocalizzazione
  `note_geolocalizzazione` text DEFAULT NULL,                 -- note sulla geolocalizzazione dell'indirizzo
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'indirizzo
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'indirizzo
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

-- | 010000018600

-- mail
-- tipologia: tabella gestita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: contiene gli indirizzi mail collegati alle anagrafiche
--
-- questa tabella contiene gli indirizzi mail collegati alle anagrafiche, con le informazioni relative al ruolo
-- dell'indirizzo, alle notifiche, alla PEC, al server di posta e alle
-- 
CREATE TABLE IF NOT EXISTS `mail` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_ruolo` int(11) DEFAULT NULL,                            -- chiave esterna per il ruolo dell'indirizzo mail
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica a cui è collegata la mail
  `indirizzo` char(128) DEFAULT NULL,                         -- indirizzo mail
  `note` char(128) DEFAULT NULL,                              -- note sull'indirizzo mail
  `se_notifiche` tinyint(1) DEFAULT NULL,                     -- se l'indirizzo mail è utilizzato per le notifiche
  `se_pec` tinyint(1) DEFAULT NULL,                           -- se l'indirizzo mail è una PEC
  `server` char(128) DEFAULT NULL,                            -- server di posta in uscita (SMTP)
  `timestamp_aggiornamento` int(11) DEFAULT NULL,             -- timestamp di aggiornamento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'indirizzo mail
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_inserimento` int(11) DEFAULT NULL               -- chiave esterna per l'account che ha inserito l'indirizzo mail
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000020600

-- mastri
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene i mastri contabili
--
-- questa tabella contiene i mastri contabili, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `mastri` (                           --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                           -- chiave esterna ricorsiva per il mastro genitore
  `id_tipologia` int(11) DEFAULT NULL,                          -- chiave esterna per la tipologia del mastro
  `codice` char(64) DEFAULT NULL,                               -- codice del mastro
  `prefisso_modula` char(64) DEFAULT NULL,                      -- prefisso per il codice modula
  `codice_modula` char(64) DEFAULT NULL,                        -- codice modula
  `id_anagrafica_indirizzi` int(11) DEFAULT NULL,               -- chiave esterna per l'anagrafica indirizzi collegata al mastro
  `id_anagrafica` int(11) DEFAULT NULL,                         -- chiave esterna per l'anagrafica collegata al mastro
  `id_account` int(11) DEFAULT NULL,                            -- chiave esterna per l'account collegato al mastro
  `id_progetto` char(32) DEFAULT NULL,                          -- chiave esterna per il progetto collegato al mastro
  `nome` char(64) DEFAULT NULL,                                 -- nome del mastro
  `note` text DEFAULT NULL,                                     -- note sul mastro
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito il mastro
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato il mastro
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                           --

-- | 010000022800

-- organizzazioni
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le organizzazioni
--
-- questa tabella contiene le organizzazioni, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `organizzazioni` (                   --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                           -- chiave esterna ricorsiva per l'organizzazione genitore
  `id_anagrafica` int(11) DEFAULT NULL,                         -- chiave esterna per l'anagrafica collegata all'organizzazione
  `id_ruolo` int(11) DEFAULT NULL,                              -- chiave esterna per il ruolo dell'organizzazione
  `ordine` int(11) DEFAULT NULL,                                -- ordine di visualizzazione
  `nome` char(128) DEFAULT NULL,                                -- nome dell'organizzazione
  `note` text DEFAULT NULL,                                     -- note sull'organizzazione
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito l'organizzazione
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato l'organizzazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                           --

-- | 010000027000

-- progetti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i progetti
--
-- questa tabella contiene i progetti, con le informazioni principali
--
CREATE TABLE IF NOT EXISTS `progetti` (                       --
  `id` char(32) NOT NULL,                                     -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia di progetto
  `id_pianificazione` int(11) DEFAULT NULL,                   -- chiave esterna per la pianificazione del progetto
  `id_cliente` int(11) DEFAULT NULL,                          -- chiave esterna per l'anagrafica del cliente
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo del progetto
  `id_ranking` int(11) DEFAULT NULL,                          -- chiave esterna per il ranking del progetto
  `id_articolo` char(32) DEFAULT NULL,                        -- chiave esterna per l'articolo collegato al progetto
  `id_prodotto` char(32) DEFAULT NULL,                        -- chiave esterna per il prodotto collegato al progetto
  `id_periodo` int(11) DEFAULT NULL,                          -- chiave esterna per il periodo del progetto
  `nome` char(255) DEFAULT NULL,                              -- nome del progetto
  `data_consegna` date DEFAULT NULL,                          -- data di consegna prevista
  `note_consegna` text DEFAULT NULL,                          -- note sulla consegna
  `note` text DEFAULT NULL,                                   -- note sul progetto
  `template` char(255) DEFAULT NULL,                          -- template associato al progetto
  `schema_html` char(128) DEFAULT NULL,                       -- schema HTML associato al progetto
  `tema_css` char(128) DEFAULT NULL,                          -- tema CSS associato al progetto
  `se_sitemap` tinyint(1) DEFAULT NULL,                       -- se il progetto deve essere incluso nella sitemap
  `se_cacheable` tinyint(1) DEFAULT NULL,                     -- se il progetto è cacheable
  `id_sito` int(11) DEFAULT NULL,                             -- chiave esterna per il sito collegato al progetto
  `id_pagina` int(11) DEFAULT NULL,                           -- chiave esterna per la pagina collegata al progetto
  `entrate_previste` decimal(16,2) DEFAULT NULL,              -- entrate previste per il progetto
  `ore_previste` decimal(16,2) DEFAULT NULL,                  -- ore previste per il progetto
  `costi_previsti` decimal(16,2) DEFAULT NULL,                -- costi previsti per il progetto
  `id_periodicita_prevista` int(11) DEFAULT NULL,             -- chiave esterna per la periodicità prevista del progetto
  `note_previsioni` text DEFAULT NULL,                        -- note sulle previsioni
  `entrate_accettazione` decimal(16,2) DEFAULT NULL,          -- entrate alla data di accettazione del progetto
  `data_accettazione` date DEFAULT NULL,                      -- data di accettazione del progetto
  `id_periodicita_accettazione` int(11) DEFAULT NULL,	      -- chiave esterna per la periodicità alla data di accettazione del progetto
  `note_accettazione` text DEFAULT NULL,                      -- note sull'accettazione
  `data_apertura` date DEFAULT NULL,                          -- data di apertura del progetto
  `note_apertura` text DEFAULT NULL,                          -- note sull'apertura
  `data_chiusura` date DEFAULT NULL,                          -- data di chiusura del progetto
  `note_chiusura` text DEFAULT NULL,                          -- note sulla chiusura
  `entrate_totali` decimal(16,2) DEFAULT NULL,                -- entrate totali del progetto
  `ore_totali` decimal(16,2) DEFAULT NULL,                    -- ore totali del progetto
  `uscite_totali` decimal(16,2) DEFAULT NULL,                 -- uscite totali del progetto
  `note_totali` text DEFAULT NULL,                            -- note sui totali
  `data_archiviazione` date DEFAULT NULL,                     -- data di archiviazione del progetto
  `note_archiviazione` text DEFAULT NULL,                     -- note sull'archiviazione
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il progetto
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il progetto
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000027400

-- progetti_categorie
-- tipologia: tabella gestita
-- rango: tabella di relazione
-- struttura: tabella base
-- funzione: tabella di relazione molti a molti tra progetti e categorie
--
-- questa tabella contiene la relazione molti a molti tra progetti e categorie, con le informazioni relative
-- all'ordine di visualizzazione e ai dati di inserimento e aggiornamento
--
CREATE TABLE IF NOT EXISTS `progetti_categorie` (             --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto
  `id_categoria` int(11) DEFAULT NULL,                        -- chiave esterna per la categoria
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la relazione
  `timestamp_aggiornamento` int(11) DEFAULT NULL,             -- timestamp di aggiornamento
  `id_account_aggiornamento` int(11) DEFAULT NULL             -- chiave esterna per l'account che ha aggiornato la relazione
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000028000

-- provincie
-- tipologia: tabella di supporto
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene le provincie italiane
--
-- questa tabella contiene le provincie italiane, con le informazioni relative alla regione di appartenenza, al nome,
-- alla sigla, al codice ISTAT, all'URL di riferimento e alle note
--
CREATE TABLE IF NOT EXISTS `provincie` (                      --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_regione` int(11) DEFAULT NULL,                          -- chiave esterna per la regione di appartenenza
  `nome` varchar(254) DEFAULT NULL,                           -- nome della provincia
  `sigla` char(8) DEFAULT NULL,                               -- sigla della provincia
  `codice_istat` char(3) DEFAULT NULL,                        -- codice ISTAT della provincia
  `url_riferimento` char(255) DEFAULT NULL,                   -- URL di riferimento della provincia
  `note` text DEFAULT NULL                                    -- note sulla provincia
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000028600

-- ranking
-- tipologia: tabella assistita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i ranking per anagrafiche e progetti
--
-- questa tabella contiene i ranking per anagrafiche e progetti, con le informazioni relative al nome, alle note,
-- all'ordine di visualizzazione e alle entità a cui si applica (clienti
-- e fornitori, progetti)
--
CREATE TABLE IF NOT EXISTS `ranking` (                        --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `nome` varchar(254) DEFAULT NULL,                           -- nome del ranking
  `note` text DEFAULT NULL,                                   -- note sul ranking
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `se_cliente` tinyint(1) DEFAULT NULL,                       -- se anagrafica cliente
  `se_fornitore` tinyint(1) DEFAULT NULL,                     -- se anagrafica fornitore
  `se_progetti` tinyint(1) DEFAULT NULL,                      -- se progetti
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il ranking
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il ranking
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
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

-- | 010000030200

-- regioni
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene le regioni italiane
--
-- questa tabella contiene le regioni italiane, con le informazioni relative allo stato di appartenenza, al nome,
-- al codice ISTAT, all'URL di riferimento e alle note
--
CREATE TABLE IF NOT EXISTS `regioni` (                        --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_stato` int(11) DEFAULT NULL,                            -- chiave esterna per lo stato di appartenenza
  `nome` char(64) DEFAULT NULL,                               -- nome della regione
  `codice_istat` char(2) DEFAULT NULL,                        -- codice ISTAT della regione
  `url_riferimento` char(255) DEFAULT NULL,                   -- URL di riferimento della regione
  `note` text DEFAULT NULL                                    -- note sulla regione
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000034800

-- ruoli_indirizzi
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene i ruoli degli indirizzi
--
-- questa tabella contiene i ruoli degli indirizzi, con le informazioni relative al nome, alle entità HTML e Font Awesome associate
-- e ai vari tipi di indirizzo (sede legale, sede operativa, residenza, domicilio); i ruoli degli indirizzi qualificano il ruolo
-- di un indirizzo rispetto a una data anagrafica
--
CREATE TABLE IF NOT EXISTS `ruoli_indirizzi` (                --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna ricorsiva per il ruolo genitore
  `nome` char(32) DEFAULT NULL,                               -- nome del ruolo
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML associata al ruolo
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome associata al ruolo
  `se_sede_legale` tinyint(1) DEFAULT NULL,                   -- se l'indirizzo è una sede legale
  `se_sede_operativa` tinyint(1) DEFAULT NULL,                -- se l'indirizzo è una sede operativa
  `se_residenza` tinyint(1) DEFAULT NULL,                     -- se l'indirizzo è una residenza
  `se_domicilio` tinyint(1) DEFAULT NULL                      -- se l'indirizzo è un domicilio
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000034850

-- ruoli_mail
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene i ruoli delle mail
--
-- questa tabella contiene i ruoli delle mail, con le informazioni relative al nome, alle entità HTML e Font Awesome associate
-- e ai vari tipi di mail (XML, commerciale, produzione, amministrazione, acquisti, ordini, helpdesk); i ruoli delle mail qualificano
-- il ruolo di un indirizzo mail rispetto a una data anagrafica
--
CREATE TABLE IF NOT EXISTS `ruoli_mail` (                     --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna ricorsiva per il ruolo genitore
  `nome` char(128) DEFAULT NULL,                              -- nome del ruolo
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML associata al ruolo
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome associata al ruolo
  `se_xml` tinyint(1) DEFAULT NULL,                           -- se l'indirizzo mail è di tipo XML
  `se_commerciale` tinyint(1) DEFAULT NULL,                   -- se l'indirizzo mail è di tipo commerciale
  `se_produzione` tinyint(1) DEFAULT NULL,                    -- se l'indirizzo mail è di tipo produzione
  `se_amministrazione` tinyint(1) DEFAULT NULL,               -- se l'indirizzo mail è di tipo amministrazione
  `se_acquisti` tinyint(1) DEFAULT NULL,                      -- se l'indirizzo mail è di tipo acquisti
  `se_ordini` tinyint(1) DEFAULT NULL,                        -- se l'indirizzo mail è di tipo ordini
  `se_helpdesk` tinyint(1) DEFAULT NULL                       -- se l'indirizzo mail è di tipo helpdesk
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000042000

-- stati
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene gli stati del mondo
-- 
-- questa tabella contiene gli stati del mondo, con le informazioni relative al continente di appartenenza, al nome,
-- ai codici ISO e ISTAT, all'URL di riferimento e alle note
--
CREATE TABLE IF NOT EXISTS `stati` (                          --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_continente` int(11) DEFAULT NULL,                       -- chiave esterna per il continente di appartenenza
  `nome` char(128) DEFAULT NULL,                              -- nome dello stato
  `nome_esteso` char(128) DEFAULT NULL,                       -- nome esteso dello stato
  `url_riferimento` char(255) DEFAULT NULL,                   -- URL di riferimento dello stato
  `note` text DEFAULT NULL,                                   -- note sullo stato
  `iso31661alpha2` char(2) DEFAULT NULL,                      -- codice ISO 3166-1 alpha-2 dello stato
  `iso31661alpha3` char(3) DEFAULT NULL,                      -- codice ISO 3166-1 alpha-3 dello stato
  `codice_istat` char(4) DEFAULT NULL,                        -- codice ISTAT dello stato
  `data_archiviazione` date DEFAULT NULL                      -- data di archiviazione dello stato
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000042500

-- step
-- tipologia: tabella gestita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: contiene gli step dei funnel
--
-- questa tabella contiene gli step dei funnel, con le informazioni relative al funnel di appartenenza, all'ordine,
-- al nome e alle note
--
CREATE TABLE `step` (                                         --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_funnel` int(11) DEFAULT NULL,                           -- chiave esterna per il funnel di appartenenza
  `ordine` char(32) DEFAULT NULL,                             -- ordine dello step nel funnel
  `nome` char(128) DEFAULT NULL,                              -- nome dello step
  `note` text DEFAULT NULL                                    -- note sullo step
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

-- | 010000043600

-- telefoni
-- tipologia: tabella gestita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: contiene i numeri di telefono delle anagrafiche
--
-- questa tabella contiene i numeri di telefono delle anagrafiche, con le informazioni relative alla tipologia,
-- al numero, alle notifiche e alle anagrafiche a cui sono associati
--
CREATE TABLE `telefoni` (                                     --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica a cui è associato il numero di telefono
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia del numero di telefono
  `numero` char(32) DEFAULT NULL,                             -- numero di telefono
  `note` text DEFAULT NULL,                                   -- note sul numero di telefono
  `se_notifiche` tinyint(1) DEFAULT NULL,                     -- flag che indica se il numero di telefono è abilitato alle notifiche
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il numero di telefono
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il numero di telefono
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

-- | 010000050000

-- tipologie_anagrafica
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di anagrafica
--
-- questa tabella contiene le tipologie di anagrafica, con le informazioni relative al nome, alla sigla e alle
-- funzionalità associate
--
CREATE TABLE IF NOT EXISTS `tipologie_anagrafica` (           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `nome` char(64) DEFAULT NULL,                               -- nome della tipologia
  `sigla` char(32) DEFAULT NULL,                              -- sigla della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `se_persona_fisica` tinyint(1) DEFAULT NULL,                -- flag che indica se la tipologia rappresenta persone fisiche
  `se_persona_giuridica` tinyint(1) DEFAULT NULL,             -- flag che indica se la tipologia rappresenta persone giuridiche
  `se_pubblica_amministrazione` tinyint(1) DEFAULT NULL,      -- flag che indica se la tipologia rappresenta pubbliche amministrazioni
  `se_ecommerce` tinyint(1) DEFAULT NULL,                     -- flag che indica se la tipologia è associabile all'e-commerce
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000050400

-- tipologie_attivita
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di attività
-- 
-- questa tabella contiene le tipologie di attività, con le informazioni relative al nome, al codice e alle
-- funzionalità associate
--
CREATE TABLE IF NOT EXISTS `tipologie_attivita` (             --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `codice` char(32) DEFAULT NULL,                             -- codice della tipologia
  `nome` char(64) DEFAULT NULL,                               -- nome della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `se_anagrafica` tinyint(1) DEFAULT NULL,                    -- flag che indica se la tipologia è associabile alle anagrafiche
  `se_agenda` tinyint(1) DEFAULT NULL,                        -- flag che indica se la tipologia è associabile all'agenda
  `se_sistema` tinyint(1) DEFAULT NULL,                       -- flag che indica se la tipologia è una tipologia di sistema
  `se_stampa` tinyint(1) DEFAULT NULL,                        -- flag che indica se la tipologia è associabile alle stampe
  `se_cartellini` tinyint(1) DEFAULT NULL,                    -- flag che indica se la tipologia è associabile ai cartellini
  `se_corsi` tinyint(1) DEFAULT NULL,                         -- flag che indica se la tipologia è associabile ai corsi
  `se_accesso` tinyint(1) DEFAULT NULL,                       -- flag che indica se la tipologia è associabile agli accessi
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000050900

-- tipologie_contratti
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di contratti
--
-- questa tabella contiene le tipologie di contratti, con le informazioni relative al nome, al prodotto collegato
-- e alle funzionalità associate (tesseramento, abbonamento, iscrizione, immobili, acquisto, locazione, libero, prenotazione, scalare,
-- affiliazione, online)
--
CREATE TABLE `tipologie_contratti` (                          --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `nome` char(64) DEFAULT NULL,                               -- nome della tipologia
  `id_prodotto` char(32) DEFAULT NULL,                        -- chiave esterna per il prodotto collegato
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto collegato
  `id_categoria_progetti` int(11) DEFAULT NULL,               -- chiave esterna per la categoria di progetti collegata
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `se_tesseramento` tinyint(1) DEFAULT NULL,                  -- se tesseramento
  `se_abbonamento` tinyint(1) DEFAULT NULL,                   -- se abbonamento
  `se_iscrizione` tinyint(1) DEFAULT NULL,                    -- se iscrizione
  `se_immobili` tinyint(1) DEFAULT NULL,                      -- se immobili
  `se_acquisto` tinyint(1) DEFAULT NULL,                      -- se acquisto
  `se_locazione` tinyint(1) DEFAULT NULL,                     -- se locazione
  `se_libero` tinyint(1) DEFAULT NULL,                        -- se libero
	`se_prenotazione` tinyint(1) DEFAULT NULL,                -- se prenotazione
	`se_scalare` tinyint(1) DEFAULT NULL,                     -- se scalare
  `se_affiliazione` tinyint(1) DEFAULT NULL,                  -- se affiliazione
  `se_online` tinyint(1) DEFAULT NULL,                        -- se online
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000051000

-- tipologie_corrispondenza
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di corrispondenza
--
-- questa tabella contiene le tipologie di corrispondenza, con le informazioni relative
-- al nome e alle funzionalità associate (massivo, corrispondenza, pesata, atto, ricevuta di ritorno)
--
CREATE TABLE IF NOT EXISTS `tipologie_corrispondenza` (         --
  `id` int(11) NOT NULL,                                        -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                           -- chiave esterna per la tipologia genitore
  `nome` char(255) DEFAULT NULL,                                -- nome della tipologia
  `se_massivo` tinyint(1) DEFAULT NULL,                         -- se massivo
  `se_corrispondenza` tinyint(1) DEFAULT NULL,                  -- se corrispondenza
  `se_pesata` tinyint(1) DEFAULT NULL,                          -- se pesata
  `se_atto` tinyint(1) DEFAULT NULL,                            -- se atto
  `se_ricevuta_ritorno` tinyint(1) DEFAULT NULL,                -- se ricevuta di ritorno
  `id_account_inserimento` int(11) DEFAULT NULL,                -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,                 -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL                -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                            --

-- | 010000052600

-- tipologie_documenti
-- tipologia: tabella di supporto
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di documenti
--
-- questa tabella contiene le tipologie di documenti, con le informazioni relative al nome,
-- al codice, alle funzionalità associate e ai modelli di stampa
--
CREATE TABLE IF NOT EXISTS `tipologie_documenti` (            --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `codice` char(32) DEFAULT NULL,                             -- codice della tipologia
  `numerazione` char(1) DEFAULT NULL,                         -- tipo di numerazione (A=automatica, M=manuale, N=nessuna)
  `nome` char(255) DEFAULT NULL,                              -- nome della tipologia
  `sigla` char(16) DEFAULT NULL,                              -- sigla della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `se_fattura` tinyint(1) DEFAULT NULL,                       -- se fattura
  `se_nota_credito` tinyint(1) DEFAULT NULL,                  -- se nota di credito
  `se_nota_debito` tinyint(1) DEFAULT NULL,                   -- se nota di debito
  `se_trasporto` tinyint(1) DEFAULT NULL,                     -- se trasporto
  `se_pro_forma` tinyint(1) DEFAULT NULL,                     -- se pro forma
  `se_offerta` tinyint(1) DEFAULT NULL,                       -- se offerta
  `se_ordine` tinyint(1) DEFAULT NULL,                        -- se ordine
  `se_missione` tinyint(1) DEFAULT NULL,                      -- se missione
  `se_ricevuta` tinyint(1) DEFAULT NULL,                      -- se ricevuta
  `se_ecommerce` tinyint(1) DEFAULT NULL,                     -- se e-commerce
  `stampa_xml` char(255) DEFAULT NULL,                        -- modello di stampa XML
  `stampa_pdf` char(255) DEFAULT NULL,                        -- modello di stampa PDF
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000053000

-- tipologie_indirizzi
-- tipologia: tabella standard
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di indirizzi
--
-- questa tabella contiene le tipologie di indirizzi, con le informazioni relative al nome e alle icone associate
--
CREATE TABLE IF NOT EXISTS `tipologie_indirizzi` (            --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `nome` char(32) DEFAULT NULL,                               -- nome della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000056200

-- tipologie_telefoni
-- tipologia: tabella assistita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di telefoni
-- 
-- questa tabella contiene le tipologie di telefoni, con le informazioni relative al nome e alle icone associate
--
CREATE TABLE `tipologie_telefoni` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `nome` char(32) DEFAULT NULL,                               -- nome della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000056800

-- tipologie_url
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella ricorsiva
-- funzione: contiene le tipologie di URL
-- 
-- questa tabella contiene le tipologie di URL, con le informazioni relative al nome e alle icone associate
--
CREATE TABLE IF NOT EXISTS `tipologie_url` (                  --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_genitore` int(11) DEFAULT NULL,                         -- chiave esterna per la tipologia genitore
  `ordine` int(11) DEFAULT NULL,                              -- ordine di visualizzazione
  `nome` char(64) DEFAULT NULL,                               -- nome della tipologia
  `html_entity` char(8) DEFAULT NULL,                         -- entità HTML per l'icona della tipologia
  `font_awesome` char(16) DEFAULT NULL,                       -- icona Font Awesome per la tipologia
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito la tipologia
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato la tipologia
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000060000

-- todo
-- tipologia: tabella gestita
-- rango: tabella principale
-- struttura: tabella base
-- funzione: contiene i todo del sistema
--
-- questa tabella contiene i todo del sistema, con le informazioni relative alla tipologia, al codice, all'anagrafica,
-- al cliente, all'indirizzo, al luogo, alla data di apertura, alla scadenza, alla programmazione, alla chiusura,
-- al nome, al testo, al contatto, al progetto, al documento, all'istruzione, alla pianificazione, all'immobile,
-- all'archiviazione, alle note e agli account di inserimento e aggiornamento
--
CREATE TABLE IF NOT EXISTS `todo` (                           --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia del todo
  `codice` char(32) DEFAULT NULL,                             -- codice univoco del todo
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica associata al todo
  `id_cliente` int(11) DEFAULT NULL,                          -- chiave esterna per il cliente associato al todo
  `id_indirizzo` int(11) DEFAULT NULL,                        -- chiave esterna per l'indirizzo associato al todo
  `id_luogo` int(11) DEFAULT NULL,                            -- chiave esterna per il luogo associato al todo
  `timestamp_apertura` int(11) DEFAULT NULL,                  -- timestamp di apertura del todo
  `data_scadenza` date DEFAULT NULL,                          -- data di scadenza del todo
  `ora_scadenza` time DEFAULT NULL,                           -- ora di scadenza del todo
  `note_scadenza` text DEFAULT NULL,                          -- note sulla scadenza del todo
  `data_programmazione` date DEFAULT NULL,                    -- data di programmazione del todo
  `ora_inizio_programmazione` time DEFAULT NULL,              -- ora di inizio della programmazione del todo
  `ora_fine_programmazione` time DEFAULT NULL,                -- ora di fine della programmazione del todo
  `anno_programmazione` year(4) DEFAULT NULL,                 -- anno di programmazione del todo
  `settimana_programmazione` int(11) DEFAULT NULL,            -- settimana di programmazione del todo
  `ore_programmazione` decimal(5,2) DEFAULT NULL,             -- ore di programmazione del todo
  `note_programmazione` text DEFAULT NULL,                    -- note sulla programmazione del todo
  `data_chiusura` date DEFAULT NULL,                          -- data di chiusura del todo
  `note_chiusura` text DEFAULT NULL,                          -- note sulla chiusura del todo
  `nome` char(255) DEFAULT NULL,                              -- nome del todo 
  `testo` text DEFAULT NULL,                                  -- testo del todo
  `id_contatto` int(11) DEFAULT NULL,                         -- chiave esterna per il contatto associato al todo
  `id_progetto` char(32) DEFAULT NULL,                        -- chiave esterna per il progetto associato al todo
  `id_documento` int(11) DEFAULT NULL,                        -- chiave esterna per il documento associato al todo
  `id_documenti_articoli` int(11) DEFAULT NULL,               -- chiave esterna per l'articolo del documento associato al todo
  `id_istruzione` int(11) DEFAULT NULL,                       -- chiave esterna per l'istruzione associata al todo
  `id_pianificazione` int(11) DEFAULT NULL,                   -- chiave esterna per la pianificazione associata al todo
  `id_immobile` int(11) DEFAULT NULL,                         -- chiave esterna per l'immobile associato al todo
  `note_pianificazione` text DEFAULT NULL,                    -- note sulla pianificazione del todo
  `data_archiviazione` date DEFAULT NULL,                     -- data di archiviazione del todo
  `note_archiviazione` text DEFAULT NULL,                     -- note sull'archiviazione del todo
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito il todo
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato il todo
  `timestamp_aggiornamento` int(11) DEFAULT NULL              -- timestamp di aggiornamento
) ENGINE=InnoDB DEFAULT CHARSET=utf8;                         --

-- | 010000062600

-- url
-- tipologia: tabella gestita
-- rango: tabella secondaria
-- struttura: tabella base
-- funzione: contiene gli URL delle anagrafiche
--
-- questa tabella contiene gli URL delle anagrafiche, con le informazioni relative alla tipologia, al nome,
-- al nome utente e alla password, oltre che all'URL vero e proprio
--
CREATE TABLE IF NOT EXISTS `url` (                            --
  `id` int(11) NOT NULL,                                      -- chiave primaria
  `id_tipologia` int(11) DEFAULT NULL,                        -- chiave esterna per la tipologia dell'URL
  `id_anagrafica` int(11) DEFAULT NULL,                       -- chiave esterna per l'anagrafica a cui è associato l'URL
  `url` char(255) DEFAULT NULL,                               -- URL
  `nome` char(128) DEFAULT NULL,                              -- nome dell'URL
  `username` char(128) DEFAULT NULL,                          -- nome utente per l'accesso all'URL
  `password` char(128) DEFAULT NULL,                          -- password per l'accesso all'URL
  `note` text DEFAULT NULL,                                   -- note sull'URL
  `id_account_inserimento` int(11) DEFAULT NULL,              -- chiave esterna per l'account che ha inserito l'URL
  `timestamp_inserimento` int(11) DEFAULT NULL,               -- timestamp di inserimento
  `id_account_aggiornamento` int(11) DEFAULT NULL,            -- chiave esterna per l'account che ha aggiornato l'URL
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
