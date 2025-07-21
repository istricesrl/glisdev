--
-- TABELLE
-- questo file contiene le query per la creazione delle tabelle; si noti che non devono essere inseriti qui i valori
-- di auto increment, mentre vanno specificati per tabella il CHARSET ma non il COLLATE.
--
-- INDICE DEGLI SCRIPT
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
-- CRITERI DI VERIFICA
-- una tabella si può marcare come verificata dopo aver controllato le seguenti cose:
-- - non è deprecata (se lo è, eliminarla)
-- - le colonne corrispondono al database master
-- - l'ordine delle colonne rispetta l'ordine master
-- - le colonne deprecate vanno eliminate
-- - le colonne sono correttamente documentate, in ordine, nel relativo file dox
-- - non viene riportato il valore di AUTO INCREMENT
--
-- TODO
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
