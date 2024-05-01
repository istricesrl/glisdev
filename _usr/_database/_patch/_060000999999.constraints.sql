--
-- LIMITI
-- questo file contiene le query per l'inserimento dei limiti nelle tabelle
--
-- CRITERI DI VERIFICA
-- una definizione di constraint si può dire verificata se:
-- - non si riferisce a tabelle deprecate e non contiene colonne deprecate né punta a tabelle o colonne deprecate
-- - le colonne vengono nominate nello stesso ordine in cui appaiono nella tabella
-- - tutte le colonne della tabella che rappresentano una chiave esterna sono nominate
-- - il comportamento di ogni constraint (SET NULL / NO ACTION / CASCADE) è stato verificato e approvato
-- - i nomi dei constraint sono numerati in maniera ascendente e univoca
-- - i nomi dei constraint contengono il suffisso _nofollow a meno che non sia strettamente necessario ometterlo
-- - ogni constraint è correttamente documentato con il giusto nome, in ordine, nel relativo file dox
--

-- | 060000000100

-- account
ALTER TABLE `account`
    ADD CONSTRAINT `account_ibfk_01_nofollow` FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_ibfk_02_nofollow` FOREIGN KEY (`id_mail`) REFERENCES `mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_ibfk_03_nofollow` FOREIGN KEY (`id_affiliazione`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_ibfk_04`          FOREIGN KEY (`id_url`) REFERENCES `url` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000200

-- account_gruppi
ALTER TABLE `account_gruppi`
    ADD CONSTRAINT `account_gruppi_ibfk_01`             FOREIGN KEY (`id_account`) REFERENCES `account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_02_nofollow`    FOREIGN KEY (`id_gruppo`) REFERENCES `gruppi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- | 060000000300

-- account_gruppi_attribuzione
ALTER TABLE `account_gruppi_attribuzione`
    ADD CONSTRAINT `account_gruppi_attribuzione_ibfk_01`            FOREIGN KEY (`id_account`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_gruppi_attribuzione_ibfk_02_nofollow`   FOREIGN KEY (`id_gruppo`) REFERENCES `gruppi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_gruppi_attribuzione_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `account_gruppi_attribuzione_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000400

-- anagrafica
ALTER TABLE `anagrafica`    
    ADD CONSTRAINT `anagrafica_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_ibfk_02_nofollow` FOREIGN KEY (`id_badge`) REFERENCES `badge` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_ibfk_03_nofollow` FOREIGN KEY (`id_pec_sdi`) REFERENCES `mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_ibfk_04_nofollow` FOREIGN KEY (`id_regime`) REFERENCES `regimi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_05_nofollow` FOREIGN KEY (`id_stato_nascita`) REFERENCES `stati` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_06_nofollow` FOREIGN KEY (`id_comune_nascita`) REFERENCES `comuni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_07_nofollow` FOREIGN KEY (`id_ranking`) REFERENCES `ranking` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_08_nofollow` FOREIGN KEY (`id_agente`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_09_nofollow` FOREIGN KEY (`id_responsabile_operativo`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000500

-- anagrafica_categorie
ALTER TABLE `anagrafica_categorie`
    ADD CONSTRAINT `anagrafica_categorie_ibfk_01`           FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_02_nofollow`  FOREIGN KEY (`id_categoria`) REFERENCES `categorie_anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000600

-- anagrafica_certificazioni
ALTER TABLE `anagrafica_certificazioni`
    ADD CONSTRAINT `anagrafica_certificazioni_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_certificazioni_ibfk_02_nofollow`      FOREIGN KEY (`id_certificazione`) REFERENCES `certificazioni` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_certificazioni_ibfk_03_nofollow`      FOREIGN KEY (`id_emittente`) REFERENCES `anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_certificazioni_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_certificazioni_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000900

-- anagrafica_indirizzi
ALTER TABLE `anagrafica_indirizzi`
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_02_nofollow`      FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_03_nofollow`      FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_indirizzi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000001300

-- articoli
ALTER TABLE `articoli`
    ADD CONSTRAINT `articoli_ibfk_01_nofollow` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_02_nofollow` FOREIGN KEY (`id_reparto`) REFERENCES `reparti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL, 
    ADD CONSTRAINT `articoli_ibfk_03_nofollow` FOREIGN KEY (`id_colore`) REFERENCES `colori` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_04_nofollow` FOREIGN KEY (`id_periodicita`) REFERENCES `periodicita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_05_nofollow` FOREIGN KEY (`id_tipologia_rinnovo`) REFERENCES `tipologie_rinnovi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `articoli_ibfk_06_nofollow` FOREIGN KEY (`id_udm_dimensioni`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_07_nofollow` FOREIGN KEY (`id_udm_peso`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_08_nofollow` FOREIGN KEY (`id_udm_volume`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_09_nofollow` FOREIGN KEY (`id_udm_capacita`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_10_nofollow` FOREIGN KEY (`id_udm_durata`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `articoli_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000001800

-- attivita
ALTER TABLE `attivita`
    ADD CONSTRAINT `attivita_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `attivita` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `attivita_ibfk_02_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_attivita` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `attivita_ibfk_03_nofollow` FOREIGN KEY (`id_cliente`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_04_nofollow` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_05_nofollow` FOREIGN KEY (`id_luogo`) REFERENCES `luoghi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_06_nofollow` FOREIGN KEY (`id_anagrafica_programmazione`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_07_nofollow` FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_08_nofollow` FOREIGN KEY (`id_mailing`) REFERENCES `mailing` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_09_nofollow` FOREIGN KEY (`id_mail`) REFERENCES `mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `attivita_ibfk_10_nofollow` FOREIGN KEY (`id_documento`) REFERENCES `documenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_11_nofollow` FOREIGN KEY (`id_pagamento`) REFERENCES `pagamenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_12_nofollow` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_13_nofollow` FOREIGN KEY (`id_todo`) REFERENCES `todo` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_14_nofollow` FOREIGN KEY (`id_mastro_provenienza`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_15_nofollow` FOREIGN KEY (`id_mastro_destinazione`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_16_nofollow` FOREIGN KEY (`id_matricola`) REFERENCES `matricole` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `attivita_ibfk_17_nofollow` FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_18_nofollow` FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_19_nofollow` FOREIGN KEY (`id_contatto`) REFERENCES `contatti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `attivita_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000002100

-- audio
ALTER TABLE `audio`
    ADD CONSTRAINT `audio_ibfk_01_nofollow` FOREIGN KEY (`id_lingua`) REFERENCES `lingue` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_02_nofollow` FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_audio` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `audio_ibfk_03_nofollow` FOREIGN KEY (`id_embed`) REFERENCES `embed` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_03`          FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_04`          FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_05`          FOREIGN KEY (`id_file`) REFERENCES `file` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_06`          FOREIGN KEY (`id_risorsa`) REFERENCES `risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_07`          FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_08`          FOREIGN KEY (`id_categoria_prodotti`) REFERENCES `categorie_prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_09`          FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_10`          FOREIGN KEY (`id_categoria_notizie`) REFERENCES `categorie_notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_13`          FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_14`          FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_15`          FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_16`          FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_17`          FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `audio_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000002250

-- badge
ALTER TABLE `badge`
    ADD CONSTRAINT `badge_ibfk_01` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_badge` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
       ADD CONSTRAINT `badge_ibfk_02` FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `badge_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
       ADD CONSTRAINT `badge_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000002300

-- banner
ALTER TABLE `banner`
	ADD CONSTRAINT `banner_ibfk_01` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_banner` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
   	ADD CONSTRAINT `banner_ibfk_02_nofollow` FOREIGN KEY (`id_inserzionista`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `banner_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
   	ADD CONSTRAINT `banner_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000002900

-- caratteristiche
ALTER TABLE `caratteristiche`
    ADD CONSTRAINT `caratteristiche_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `caratteristiche_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000003000

-- carrelli
ALTER TABLE `carrelli`
    ADD CONSTRAINT `carrelli_ibfk_01`          FOREIGN KEY (`destinatario_id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_02_nofollow` FOREIGN KEY (`destinatario_id_provincia`) REFERENCES `provincie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_03_nofollow` FOREIGN KEY (`destinatario_id_stato`) REFERENCES `stati` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_04`          FOREIGN KEY (`intestazione_id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_05_nofollow` FOREIGN KEY (`intestazione_id_comune`) REFERENCES `comuni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_06_nofollow` FOREIGN KEY (`intestazione_id_provincia`) REFERENCES `provincie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_07_nofollow` FOREIGN KEY (`intestazione_id_stato`) REFERENCES `stati` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_08_nofollow` FOREIGN KEY (`id_listino`) REFERENCES `listini` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_09_nofollow` FOREIGN KEY (`id_reseller`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_10_nofollow` FOREIGN KEY (`id_affiliato`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_11_nofollow` FOREIGN KEY (`intestazione_id_account`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
	ADD CONSTRAINT `carrelli_ibfk_12_nofollow` FOREIGN KEY (`destinatario_id_account`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_13_nofollow` FOREIGN KEY (`fatturazione_id_tipologia_documento`) REFERENCES `tipologie_documenti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_ibfk_14_nofollow` FOREIGN KEY (`intestazione_id_tipologia_anagrafica`) REFERENCES `tipologie_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_ibfk_15_nofollow` FOREIGN KEY (`destinatario_id_tipologia_anagrafica`) REFERENCES `tipologie_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_ibfk_16_nofollow` FOREIGN KEY (`id_affiliazione`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000003050

-- carrelli_articoli
ALTER TABLE `carrelli_articoli`
    ADD CONSTRAINT `carrelli_articoli_ibfk_01`             FOREIGN KEY (`id_carrello`) REFERENCES `carrelli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_articoli_ibfk_02_nofollow`    FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_articoli_ibfk_03_nofollow`    FOREIGN KEY (`id_iva`) REFERENCES `iva` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_articoli_ibfk_04_nofollow`    FOREIGN KEY (`id_pagamento`) REFERENCES `pagamenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_articoli_ibfk_05_nofollow`    FOREIGN KEY (`destinatario_id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_articoli_ibfk_06_nofollow`    FOREIGN KEY (`id_rinnovo`) REFERENCES `rinnovi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `carrelli_articoli_ibfk_98_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `carrelli_articoli_ibfk_99_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000003100

-- categorie_anagrafica
ALTER TABLE `categorie_anagrafica`
    ADD CONSTRAINT `categorie_anagrafica_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `categorie_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `categorie_anagrafica_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_anagrafica_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000003700

-- categorie_notizie
ALTER TABLE `categorie_notizie`
    ADD CONSTRAINT `categorie_notizie_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `categorie_notizie` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `categorie_notizie_ibfk_02_nofollow` FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_notizie_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_notizie_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000003900

-- categorie_prodotti
ALTER TABLE `categorie_prodotti`
    ADD CONSTRAINT `categorie_prodotti_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `categorie_prodotti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `categorie_prodotti_ibfk_02_nofollow` FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_prodotti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_prodotti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000004300

-- categorie_progetti
ALTER TABLE `categorie_progetti`
    ADD CONSTRAINT `categorie_progetti_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `categorie_progetti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `categorie_progetti_ibfk_02` FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_progetti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_progetti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000004500

-- categorie_risorse
ALTER TABLE `categorie_risorse`
    ADD CONSTRAINT `categorie_risorse_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `categorie_risorse` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `categorie_risorse_ibfk_02_nofollow` FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_risorse_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `categorie_risorse_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000004600

-- causali
ALTER TABLE `causali`
    ADD CONSTRAINT `causali_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `causali_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000004700

-- certificazioni
ALTER TABLE `certificazioni`
    ADD CONSTRAINT `certificazioni_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `certificazioni_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000005100

-- colori
ALTER TABLE `colori`
    ADD CONSTRAINT `colori_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `colori` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000005300

-- comuni
ALTER TABLE `comuni`
    ADD CONSTRAINT `comuni_ibfk_01_nofollow` FOREIGN KEY (`id_provincia`) REFERENCES `provincie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000006700

-- contatti
ALTER TABLE `contatti`
    ADD CONSTRAINT `contatti_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_contatti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `contatti_ibfk_02_nofollow` FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contatti_ibfk_03_nofollow` FOREIGN KEY (`id_inviante`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contatti_ibfk_04_nofollow` FOREIGN KEY (`id_ranking`) REFERENCES `ranking` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contatti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contatti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000006900

-- contenuti
ALTER TABLE `contenuti`
    ADD CONSTRAINT `contenuti_ibfk_01_nofollow` FOREIGN KEY (`id_lingua`) REFERENCES `lingue` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_02`          FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_03`          FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_04`          FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_05`          FOREIGN KEY (`id_categoria_prodotti`) REFERENCES `categorie_prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_06`          FOREIGN KEY (`id_caratteristica`) REFERENCES `caratteristiche` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_07`          FOREIGN KEY (`id_marchio`) REFERENCES `marchi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_08`          FOREIGN KEY (`id_file`) REFERENCES `file` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_09`          FOREIGN KEY (`id_immagine`) REFERENCES `immagini` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_10`          FOREIGN KEY (`id_video`) REFERENCES `video` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_11`          FOREIGN KEY (`id_audio`) REFERENCES `audio` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_12`          FOREIGN KEY (`id_risorsa`) REFERENCES `risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_13`          FOREIGN KEY (`id_categoria_risorse`) REFERENCES `categorie_risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_14`          FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_15`          FOREIGN KEY (`id_popup`) REFERENCES `popup` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_16`          FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_17`          FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_18`          FOREIGN KEY (`id_categoria_notizie`) REFERENCES `categorie_notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_20`          FOREIGN KEY (`id_template`) REFERENCES `template` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_21`          FOREIGN KEY (`id_mailing`) REFERENCES `mailing` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_22`          FOREIGN KEY (`id_colore`) REFERENCES `colori` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_23`          FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_24`          FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_25`          FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_26`          FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_27`          FOREIGN KEY (`id_banner`) REFERENCES `banner` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contenuti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000007200

-- contratti
ALTER TABLE `contratti` 
    ADD CONSTRAINT `contratti_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_contratti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `contratti_ibfk_04_nofollow` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_ibfk_05_nofollow` FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_ibfk_06_nofollow` FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_ibfk_07_nofollow` FOREIGN KEY (`id_badge`) REFERENCES `badge` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000007300

-- contratti_anagrafica
ALTER TABLE `contratti_anagrafica`
    ADD CONSTRAINT `contratti_anagrafica_ibfk_01`            FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `contratti_anagrafica_ibfk_02_nofollow`   FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `contratti_anagrafica_ibfk_03_nofollow`   FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `contratti_anagrafica_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `contratti_anagrafica_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000008000

-- coupon
ALTER TABLE `coupon`
    ADD CONSTRAINT `coupon_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `coupon_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000009800

-- documenti
ALTER TABLE `documenti`
    ADD CONSTRAINT `documenti_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_documenti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `documenti_ibfk_02_nofollow` FOREIGN KEY (`id_emittente`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_03_nofollow` FOREIGN KEY (`id_sede_emittente`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_04_nofollow` FOREIGN KEY (`id_destinatario`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_05_nofollow` FOREIGN KEY (`id_sede_destinatario`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_06_nofollow` FOREIGN KEY (`id_coupon`) REFERENCES `coupon` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_07_nofollow` FOREIGN KEY (`id_condizione_pagamento`) REFERENCES `condizioni_pagamento` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_08_nofollow` FOREIGN KEY (`id_mastro_provenienza`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_09_nofollow` FOREIGN KEY (`id_mastro_destinazione`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_10_nofollow` FOREIGN KEY (`id_causale`) REFERENCES `causali` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_11_nofollow` FOREIGN KEY (`id_trasportatore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_12_nofollow` FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_13_nofollow` FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `documenti_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- NOTA id_sede_emittente e id_sede_destinatario non dovrebbero referenziare la tabella anagrafica_indirizzi?
-- NOTA la colonna id_listino non dovrebbe essere nel documento e comandare sull'id_listino delle voci?

-- | 060000012000

-- edifici
ALTER TABLE `edifici`
    ADD CONSTRAINT `edifici_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_edifici` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `edifici_ibfk_02_nofollow` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `edifici_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `edifici_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015000

-- file
ALTER TABLE `file`
    ADD CONSTRAINT `file_ibfk_01_nofollow`  FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_file` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `file_ibfk_02`           FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_03`           FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL, 
    ADD CONSTRAINT `file_ibfk_04`           FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_05`           FOREIGN KEY (`id_categoria_prodotti`) REFERENCES `categorie_prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_06`           FOREIGN KEY (`id_todo`) REFERENCES `todo` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_07`           FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_08`           FOREIGN KEY (`id_template`) REFERENCES `template` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_09`           FOREIGN KEY (`id_mailing`) REFERENCES `mailing` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_10`           FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_11`           FOREIGN KEY (`id_categoria_notizie`) REFERENCES `categorie_notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_12`           FOREIGN KEY (`id_risorsa`) REFERENCES `risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_13`           FOREIGN KEY (`id_categoria_risorse`) REFERENCES `categorie_risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_14_nofollow`  FOREIGN KEY (`id_lingua`) REFERENCES `lingue` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_15`           FOREIGN KEY (`id_mail_out`) REFERENCES `mail_out` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_16`           FOREIGN KEY (`id_mail_sent`) REFERENCES `mail_sent` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_17`           FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_18`           FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_19`           FOREIGN KEY (`id_documento`) REFERENCES `documenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_20`           FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_21`           FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_22`           FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_23`           FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_24`           FOREIGN KEY (`id_valutazione`) REFERENCES `valutazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_25`           FOREIGN KEY (`id_rinnovo`) REFERENCES `rinnovi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_26`           FOREIGN KEY (`id_anagrafica_certificazioni`) REFERENCES `anagrafica_certificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_27`           FOREIGN KEY (`id_valutazione_certificazioni`) REFERENCES `valutazioni_certificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_28`           FOREIGN KEY (`id_licenza`) REFERENCES `licenze` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_29`           FOREIGN KEY (`id_attivita`) REFERENCES `attivita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `file_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015200

-- gruppi
ALTER TABLE `gruppi`
    ADD CONSTRAINT `gruppi_ibfk_01`             FOREIGN KEY (`id_genitore`) REFERENCES `gruppi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `gruppi_ibfk_02`             FOREIGN KEY (`id_organizzazione`) REFERENCES `organizzazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `gruppi_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `gruppi_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015400

-- iban
ALTER TABLE `iban`
    ADD CONSTRAINT `iban_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `iban_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `iban_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015600

-- immagini
ALTER TABLE `immagini`
    ADD CONSTRAINT `immagini_ibfk_01`           FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_02`           FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_03`           FOREIGN KEY (`id_file`) REFERENCES `file` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_04`           FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_05`           FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_06`           FOREIGN KEY (`id_categoria_prodotti`) REFERENCES `categorie_prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_07`           FOREIGN KEY (`id_risorsa`) REFERENCES `risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_08`           FOREIGN KEY (`id_categoria_risorse`) REFERENCES `categorie_risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_09`           FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_10`           FOREIGN KEY (`id_categoria_notizie`) REFERENCES `categorie_notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_11`           FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL, 
    ADD CONSTRAINT `immagini_ibfk_12_nofollow`  FOREIGN KEY (`id_lingua`) REFERENCES `lingue` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_13_nofollow`  FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_immagini` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `immagini_ibfk_14`           FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_15`           FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_16`           FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_17`           FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_18`           FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_19`           FOREIGN KEY (`id_valutazione`) REFERENCES `valutazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_20`           FOREIGN KEY (`id_rinnovo`) REFERENCES `rinnovi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_21`           FOREIGN KEY (`id_banner`) REFERENCES `banner` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immagini_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015700

-- immobili
ALTER TABLE `immobili`
    ADD CONSTRAINT `immobili_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_immobili` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `immobili_ifbk_02_nofollow` FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immobili_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `immobili_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000015800

-- indirizzi
ALTER TABLE `indirizzi`
    ADD CONSTRAINT `indirizzi_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_indirizzi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `indirizzi_ibfk_02_nofollow` FOREIGN KEY (`id_comune`) REFERENCES `comuni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `indirizzi_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `indirizzi_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000016600

-- licenze
ALTER TABLE `licenze`
    ADD CONSTRAINT `licenze_ibfk_01_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_licenze` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `licenze_ibfk_02_nofollow` FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `licenze_ibfk_03_nofollow` FOREIGN KEY (`id_rivenditore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `licenze_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `licenze_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000017200

-- listini
ALTER TABLE `listini`
    ADD CONSTRAINT `listini_ibfk_01_nofollow`   FOREIGN KEY (`id_valuta`) REFERENCES `valute` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `listini_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `listini_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000018000

-- luoghi
ALTER TABLE `luoghi`
    ADD CONSTRAINT `luoghi_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `luoghi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `luoghi_ibfk_02_nofollow` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `luoghi_ibfk_03_nofollow` FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `luoghi_ibfk_04_nofollow` FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `luoghi_ibfk_05_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_luoghi`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `luoghi_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `luoghi_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000018600

-- mail
ALTER TABLE `mail`
    ADD CONSTRAINT `mail_ibfk_01`           FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_mail` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `mail_ibfk_02`           FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000018800

-- mail_out
ALTER TABLE `mail_out`
    ADD CONSTRAINT `mail_out_ibfk_01_nofollow`  FOREIGN KEY (`id_mail`) REFERENCES `mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `mail_out_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_out_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000018900

-- mail_sent
ALTER TABLE `mail_sent`
    ADD CONSTRAINT `mail_sent_ibfk_01_nofollow`     FOREIGN KEY (`id_mail`) REFERENCES `mail` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `mail_sent_ibfk_98_nofollow`     FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_sent_ibfk_99_nofollow`     FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000019000

-- mailing
ALTER TABLE `mailing`
    ADD CONSTRAINT `mailing_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mailing_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000020200

-- marchi
ALTER TABLE `marchi`
    ADD CONSTRAINT `marchi_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `marchi_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000020600

-- mastri
ALTER TABLE `mastri`
    ADD CONSTRAINT `mastri_ibfk_01_nofollow`    FOREIGN KEY (`id_genitore`) REFERENCES `mastri` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `mastri_ibfk_02_nofollow`    FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_mastri` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `mastri_ibfk_03_nofollow`    FOREIGN KEY (`id_anagrafica_indirizzi`) REFERENCES `anagrafica_indirizzi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `mastri_ibfk_04_nofollow`    FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mastri_ibfk_05_nofollow`    FOREIGN KEY (`id_account`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mastri_ibfk_06_nofollow`    FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mastri_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `mastri_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000021000

-- matricole
ALTER TABLE `matricole`
    ADD CONSTRAINT `matricole_ibfk_01_nofollow` FOREIGN KEY (`id_marchio`) REFERENCES `marchi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `matricole_ibfk_02_nofollow` FOREIGN KEY (`id_produttore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `matricole_ibfk_03_nofollow` FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `matricole_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `matricole_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000022000

-- notizie
ALTER TABLE `notizie`
    ADD CONSTRAINT `notizie_ibfk_01_nofollow`   FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_notizie` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `notizie_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `notizie_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000022200

-- notizie_categorie
ALTER TABLE `notizie_categorie`
    ADD CONSTRAINT `notizie_categorie_ibfk_01`              FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `notizie_categorie_ibfk_02`              FOREIGN KEY (`id_categoria`) REFERENCES `categorie_notizie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `notizie_categorie_ibfk_98_nofollow`     FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `notizie_categorie_ibfk_99_nofollow`     FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000022800

-- organizzazioni
ALTER TABLE `organizzazioni`
    ADD CONSTRAINT `organizzazioni_ibfk_01_nofollow`    FOREIGN KEY (`id_genitore`) REFERENCES `organizzazioni` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `organizzazioni_ibfk_02`             FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `organizzazioni_ibfk_03_nofollow`    FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `organizzazioni_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `organizzazioni_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000023100

-- pagamenti
ALTER TABLE `pagamenti`
    ADD CONSTRAINT `pagamenti_ibfk_01_nofollow`    FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_pagamenti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `pagamenti_ibfk_02`             FOREIGN KEY (`id_documento`) REFERENCES `documenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_03_nofollow`    FOREIGN KEY (`id_carrelli_articoli`) REFERENCES `carrelli_articoli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pagamenti_ibfk_04_nofollow`    FOREIGN KEY (`id_creditore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_05_nofollow`    FOREIGN KEY (`id_debitore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_06_nofollow`    FOREIGN KEY (`id_mastro_provenienza`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_07_nofollow`    FOREIGN KEY (`id_mastro_destinazione`) REFERENCES `mastri` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_08_nofollow`    FOREIGN KEY (`id_iban`) REFERENCES `iban` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `pagamenti_ibfk_09_nofollow`    FOREIGN KEY (`id_listino`) REFERENCES `listini` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_10_nofollow`    FOREIGN KEY (`id_modalita_pagamento`) REFERENCES `modalita_pagamento` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_11_nofollow`    FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_98_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagamenti_ibfk_99_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000023200

-- pagine
ALTER TABLE `pagine`
    ADD CONSTRAINT `pagine_ibfk_01_nofollow`    FOREIGN KEY (`id_genitore`) REFERENCES `pagine` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `pagine_ibfk_02_nofollow`    FOREIGN KEY (`id_contenuti`) REFERENCES `contenuti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagine_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pagine_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000023500

-- periodi
ALTER TABLE `periodi`
    ADD CONSTRAINT `periodi_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `periodi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `periodi_ibfk_02`          FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_periodi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
       ADD CONSTRAINT `periodi_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
       ADD CONSTRAINT `periodi_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
    
-- | 060000023600

-- pianificazioni
-- TODO vanno fatti tutti i constraints per i vari campi model_id_*?
ALTER TABLE `pianificazioni`
    ADD CONSTRAINT `pianificazioni_ibfk_00`             FOREIGN KEY (`id_genitore`) REFERENCES `pianificazioni` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `pianificazioni_ibfk_01`             FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_02`             FOREIGN KEY (`id_todo`) REFERENCES `todo` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_03`             FOREIGN KEY (`id_attivita`) REFERENCES `attivita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_04_nofollow`    FOREIGN KEY (`id_periodicita`) REFERENCES `periodicita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_05`             FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `pianificazioni_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000024000

-- popup
ALTER TABLE `popup`
    ADD CONSTRAINT `popup_ibfk_01_nofollow`     FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_popup` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `popup_ibfk_98_nofollow`     FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `popup_ibfk_99_nofollow`     FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000025000

-- prezzi
ALTER TABLE `prezzi`
    ADD CONSTRAINT `prezzi_ibfk_01`             FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prezzi_ibfk_02`             FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prezzi_ibfk_03_nofollow`    FOREIGN KEY (`id_listino`) REFERENCES `listini` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prezzi_ibfk_04_nofollow`    FOREIGN KEY (`id_iva`) REFERENCES `iva` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prezzi_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prezzi_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000026000

-- prodotti
ALTER TABLE `prodotti`
    ADD CONSTRAINT `prodotti_ibfk_01_nofollow`  FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_prodotti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `prodotti_ibfk_02_nofollow`  FOREIGN KEY (`id_marchio`) REFERENCES `marchi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prodotti_ibfk_03_nofollow`  FOREIGN KEY (`id_produttore`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prodotti_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prodotti_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000026400

-- prodotti_categorie
ALTER TABLE `prodotti_categorie`
    ADD CONSTRAINT `prodotti_categorie_ibfk_01`             FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `prodotti_categorie_ibfk_02_nofollow`    FOREIGN KEY (`id_categoria`) REFERENCES `categorie_prodotti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `prodotti_categorie_ibfk_03_nofollow`    FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_prodotti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `prodotti_categorie_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `prodotti_categorie_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000027000

-- progetti
ALTER TABLE `progetti`
    ADD CONSTRAINT `progetti_ibfk_01_nofollow`  FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_progetti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `progetti_ibfk_02_nofollow`  FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_03_nofollow`  FOREIGN KEY (`id_cliente`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_04_nofollow`  FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_05_nofollow`  FOREIGN KEY (`id_ranking`) REFERENCES `ranking` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_06_nofollow`  FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_07_nofollow`  FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_08_nofollow`  FOREIGN KEY (`id_periodo`) REFERENCES `periodi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000027400

-- progetti_categorie
ALTER TABLE `progetti_categorie`
    ADD CONSTRAINT `progetti_categorie_ibfk_01`             FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `progetti_categorie_ibfk_02_nofollow`    FOREIGN KEY (`id_categoria`) REFERENCES `categorie_progetti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `progetti_categorie_ibfk_98_nofollow`    FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `progetti_categorie_ibfk_99_nofollow`    FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000028000

-- provincie
ALTER TABLE `provincie`
    ADD CONSTRAINT `provincie_ibfk_01_nofollow`     FOREIGN KEY (`id_regione`) REFERENCES `regioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000028600

-- ranking
ALTER TABLE `ranking`
    ADD CONSTRAINT `ranking_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `ranking_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000029400

-- redirect
ALTER TABLE `redirect`
    ADD CONSTRAINT `redirect_ibfk_98_nofollow`  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `redirect_ibfk_99_nofollow`  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000030200

-- regioni
ALTER TABLE `regioni`
    ADD CONSTRAINT `regioni_ibfk_01_nofollow`   FOREIGN KEY (`id_stato`) REFERENCES `stati` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000030800

-- reparti
ALTER TABLE `reparti`
    ADD CONSTRAINT `reparti_ibfk_01_nofollow`   FOREIGN KEY (`id_iva`) REFERENCES `iva` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `reparti_ibfk_02_nofollow`   FOREIGN KEY (`id_settore`) REFERENCES `settori` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `reparti_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `reparti_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000031500

-- rinnovi
ALTER TABLE `rinnovi`
    ADD CONSTRAINT `rinnovi_ibfk_01` FOREIGN KEY (`id_contratto`) REFERENCES `contratti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_02` FOREIGN KEY (`id_licenza`) REFERENCES `licenze` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_03` FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_04` FOREIGN KEY (`id_tipologia_contratto`) REFERENCES `tipologie_contratti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `rinnovi_ibfk_05` FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_06` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_rinnovi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `rinnovi_ibfk_07` FOREIGN KEY (`id_periodicita`) REFERENCES `periodicita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_08_nofollow` FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `rinnovi_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000032000

-- risorse
ALTER TABLE `risorse`
    ADD CONSTRAINT `risorse_ibfk_01_nofollow`   FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_risorse` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `risorse_ibfk_02_nofollow`   FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `risorse_ibfk_03_nofollow`   FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `risorse_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `risorse_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000034000

-- ruoli_anagrafica
ALTER TABLE `ruoli_anagrafica`
    ADD CONSTRAINT `ruoli_anagrafica_ibfk_01`   FOREIGN KEY (`id_genitore`) REFERENCES `ruoli_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000034400

-- ruoli_file
ALTER TABLE `ruoli_file`
    ADD CONSTRAINT `ruoli_file_ibfk_01`     FOREIGN KEY (`id_genitore`) REFERENCES `ruoli_file` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000034850

-- ruoli_mail
ALTER TABLE `ruoli_mail`
    ADD CONSTRAINT `ruoli_mail_ibfk_01`     FOREIGN KEY (`id_genitore`) REFERENCES `ruoli_mail` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000035000

-- ruoli_prodotti
ALTER TABLE `ruoli_prodotti`
    ADD CONSTRAINT `ruoli_prodotti_ibfk_01`     FOREIGN KEY (`id_genitore`) REFERENCES `ruoli_prodotti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000037000

-- settori
ALTER TABLE `settori`
    ADD CONSTRAINT `settori_ibfk_01`            FOREIGN KEY (`id_genitore`) REFERENCES `settori` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000042000

-- stati
ALTER TABLE `stati`
    ADD CONSTRAINT `stati_ibfk_01_nofollow`     FOREIGN KEY (`id_continente`) REFERENCES `continenti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000042500

-- step
ALTER TABLE `step`
    ADD CONSTRAINT `step_ibfk_01` FOREIGN KEY (`id_funnel`) REFERENCES `funnel` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000043600

-- telefoni
ALTER TABLE `telefoni`
    ADD CONSTRAINT `telefoni_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `telefoni_ibfk_02_nofollow`      FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_telefoni` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `telefoni_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `telefoni_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000044000

-- template
ALTER TABLE `template`
    ADD CONSTRAINT `template_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `template_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000050000

-- tipologie_anagrafica
ALTER TABLE `tipologie_anagrafica`
    ADD CONSTRAINT `tipologie_anagrafica_ibfk_01_nofollow`      FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_anagrafica` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_anagrafica_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_anagrafica_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000050400

-- tipologie_attivita
ALTER TABLE `tipologie_attivita`
    ADD CONSTRAINT `tipologie_attivita_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_attivita` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_attivita_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_attivita_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000050450

-- tipologie_badge
ALTER TABLE `tipologie_badge`
    ADD CONSTRAINT `tipologie_badge_ibfk_01_nofollow`          FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_badge` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_badge_ibfk_98_nofollow`          FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_badge_ibfk_99_nofollow`          FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000050800

-- tipologie_contatti
ALTER TABLE `tipologie_contatti`
    ADD CONSTRAINT `tipologie_contatti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_contatti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_contatti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_contatti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000050900

-- tipologie_contratti
ALTER TABLE `tipologie_contratti`
    ADD CONSTRAINT `tipologie_contratti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_contratti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_contratti_ibfk_02_nofollow`        FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_contratti_ibfk_03_nofollow`        FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_contratti_ibfk_04_nofollow`        FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_contratti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_contratti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000052600

-- tipologie_documenti
ALTER TABLE `tipologie_documenti`
    ADD CONSTRAINT `tipologie_documenti_ibfk_01_nofollow`       FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_documenti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_documenti_ibfk_98_nofollow`       FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_documenti_ibfk_99_nofollow`       FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000052800

-- tipologie_edifici
ALTER TABLE `tipologie_edifici`
  ADD CONSTRAINT `tipologie_edifici_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_edifici` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tipologie_edifici_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `tipologie_edifici_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000052900

-- tipologie_immobili
ALTER TABLE `tipologie_immobili`
  ADD CONSTRAINT `tipologie_immobili_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_immobili` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tipologie_immobili_ibfk_98_nofollow` FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `tipologie_immobili_ibfk_99_nofollow` FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

  -- | 060000053000

-- tipologie_indirizzi
ALTER TABLE `tipologie_indirizzi`
    ADD CONSTRAINT `tipologie_indirizzi_ibfk_01_nofollow`       FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_indirizzi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_indirizzi_ibfk_98_nofollow`       FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_indirizzi_ibfk_99_nofollow`       FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000053200

-- tipologie_licenze
ALTER TABLE `tipologie_licenze`
    ADD CONSTRAINT `tipologie_licenze_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_licenze` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_licenze_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_licenze_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000053300

-- tipologie_luoghi
ALTER TABLE `tipologie_luoghi`
    ADD CONSTRAINT `tipologie_luoghi_ibfk_01_nofollow`          FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_mastri` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_luoghi_ibfk_98_nofollow`          FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_luoghi_ibfk_99_nofollow`          FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000053400

-- tipologie_mastri
ALTER TABLE `tipologie_mastri`
    ADD CONSTRAINT `tipologie_mastri_ibfk_01_nofollow`          FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_mastri` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_mastri_ibfk_98_nofollow`          FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_mastri_ibfk_99_nofollow`          FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000054000

-- tipologie_pagamenti
ALTER TABLE `tipologie_pagamenti`
    ADD CONSTRAINT `tipologie_pagamenti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_pagamenti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_pagamenti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_pagamenti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000054600

-- tipologie_prodotti
ALTER TABLE `tipologie_prodotti`
    ADD CONSTRAINT `tipologie_prodotti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_prodotti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_prodotti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_prodotti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000055000

-- tipologie_progetti
ALTER TABLE `tipologie_progetti`
    ADD CONSTRAINT `tipologie_progetti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_progetti` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_progetti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_progetti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000055700

-- tipologie_rinnovi
ALTER TABLE `tipologie_rinnovi`
    ADD CONSTRAINT `tipologie_progetti_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_rinnovi` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_progetti_ibfk_98_nofollow`        FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_progetti_ibfk_99_nofollow`        FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000056200

-- tipologie_telefoni
ALTER TABLE `tipologie_telefoni`
    ADD CONSTRAINT `tipologie_telefoni_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_telefoni` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000056600

-- tipologie_todo
ALTER TABLE `tipologie_todo`
    ADD CONSTRAINT `tipologie_todo_ibfk_01_nofollow`            FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_todo` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_todo_ibfk_98_nofollow`            FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_todo_ibfk_99_nofollow`            FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000056800

-- tipologie_url
ALTER TABLE `tipologie_url`
    ADD CONSTRAINT `tipologie_url_ibfk_01_nofollow`            FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_url` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_url_ibfk_98_nofollow`            FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_url_ibfk_99_nofollow`            FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000056900

-- tipologie_zone
ALTER TABLE `tipologie_zone`
    ADD CONSTRAINT `tipologie_zone_ibfk_01_nofollow`            FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_zone` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `tipologie_zone_ibfk_98_nofollow`            FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `tipologie_zone_ibfk_99_nofollow`            FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000060000

-- todo
ALTER TABLE `todo`
    ADD CONSTRAINT `todo_ibfk_01_nofollow`      FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_todo`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `todo_ibfk_02_nofollow`      FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_03_nofollow`      FOREIGN KEY (`id_cliente`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_04_nofollow`      FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_05_nofollow`      FOREIGN KEY (`id_luogo`) REFERENCES `luoghi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_06_nofollow`      FOREIGN KEY (`id_contatto`) REFERENCES `contatti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_07_nofollow`      FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_08_nofollow`      FOREIGN KEY (`id_pianificazione`) REFERENCES `pianificazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_09_nofollow`      FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `todo_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000062000

-- udm
ALTER TABLE `udm`
    ADD CONSTRAINT `udm_ibfk_01_nofollow`       FOREIGN KEY (`id_base`) REFERENCES `udm` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000062600

-- url
ALTER TABLE `url`
    ADD CONSTRAINT `url_ibfk_01_nofollow`       FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_url`(`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `url_ibfk_02_nofollow`       FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `url_ibfk_98_nofollow`       FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `url_ibfk_99_nofollow`       FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000062900

-- valutazioni
ALTER TABLE `valutazioni`
    ADD CONSTRAINT `valutazioni_ibfk_01_nofollow`       FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_02_nofollow`       FOREIGN KEY (`id_matricola`) REFERENCES `matricole` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_03_nofollow`       FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_04_nofollow`       FOREIGN KEY (`id_condizione`) REFERENCES `condizioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_05_nofollow`       FOREIGN KEY (`id_disponibilita`) REFERENCES `disponibilita` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_06_nofollow`       FOREIGN KEY (`id_classe_energetica`) REFERENCES `classi_energetiche` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_98_nofollow`       FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `valutazioni_ibfk_99_nofollow`       FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000065000

-- video
ALTER TABLE `video`
    ADD CONSTRAINT `video_ibfk_01`              FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_02`              FOREIGN KEY (`id_pagina`) REFERENCES `pagine` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_03`              FOREIGN KEY (`id_file`) REFERENCES `file` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_04`              FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_05`              FOREIGN KEY (`id_articolo`) REFERENCES `articoli` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_06`              FOREIGN KEY (`id_categoria_prodotti`) REFERENCES `categorie_prodotti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_07`              FOREIGN KEY (`id_risorsa`) REFERENCES `risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_08`              FOREIGN KEY (`id_categoria_risorse`) REFERENCES `categorie_risorse` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_09`              FOREIGN KEY (`id_notizia`) REFERENCES `notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_10`              FOREIGN KEY (`id_categoria_notizie`) REFERENCES `categorie_notizie` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_11_nofollow`     FOREIGN KEY (`id_lingua`) REFERENCES `lingue` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_12_nofollow`     FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_video` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `video_ibfk_13_nofollow`     FOREIGN KEY (`id_embed`) REFERENCES `embed` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_14`              FOREIGN KEY (`id_progetto`) REFERENCES `progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_15`              FOREIGN KEY (`id_categoria_progetti`) REFERENCES `categorie_progetti` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_16`              FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_17`              FOREIGN KEY (`id_edificio`) REFERENCES `edifici` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_18`              FOREIGN KEY (`id_immobile`) REFERENCES `immobili` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_19`              FOREIGN KEY (`id_valutazione`) REFERENCES `valutazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_98_nofollow`     FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `video_ibfk_99_nofollow`     FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000100000

-- zone
ALTER TABLE `zone`
    ADD CONSTRAINT `zone_ibfk_01_nofollow` FOREIGN KEY (`id_genitore`) REFERENCES `zone` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `zone_ibfk_02_nofollow` FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_zone` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `zone_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `zone_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000100200

-- zone_indirizzi
ALTER TABLE `zone_indirizzi`
    ADD CONSTRAINT `zone_indirizzi_ibfk_01` FOREIGN KEY (`id_zona`) REFERENCES `zone` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `zone_indirizzi_ibfk_02` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `zone_indirizzi_ibfk_98_nofollow`   FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `zone_indirizzi_ibfk_99_nofollow`   FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

-- | FINE FILE
