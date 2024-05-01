--
-- INDICI
-- questo file contiene le query per la creazione degli indici delle tabelle
--
-- CRITERI DI VERIFICA
-- una definizione di indici può dirsi verificata se:
-- - non si riferisce a tabelle deprecate e non contiene colonne deprecate
-- - riporta prima le definizioni di chiavi primarie, poi le uniche, poi gli indici generali
-- - le chiavi uniche sono nominate con il prefisso unica_ (la prima si chiama semplicemente unica)
-- - nella parte degli indici generali, riporta per primi gli indici che si riferiscono a chiavi esterne (identificate dal prefisso id_)
-- - nella parte degli indici generali, le colonne appaiono nell'ordine in cui compaiono nella tabella
-- - nella parte degli indici generali, le colonne indicizzate appaiono nello stesso ordine in cui appaiono nella tabella
-- - nella parte degli indici generali, dopo le colonne relative a chiavi esterne appaiono le colonne di flag (identificate dal prefisso se_)
-- - la parte degli indidi si chiude con gli indici multicolonna, nominati con il prefisso indice_ (il primo si chiama semplicemente indice)
-- - ogni indice è sono correttamente documentato, in ordine, nel relativo file dox
-- - la chiave primaria, se intera, è dichiarata AUTO_INCREMENT
--


-- | 030000000100

-- account
ALTER TABLE `account`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`username`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_mail` (`id_mail`),
    ADD KEY `id_affiliazione` (`id_affiliazione`),
    ADD KEY `id_url` (`id_url`),
    ADD KEY `se_attivo` (`se_attivo`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`, `id_anagrafica`, `username`, `id_mail`, `id_affiliazione`, `password`, `se_attivo`, `token`),
    ADD KEY `indice_token` (`id`,`token`);

-- | 030000000101

-- account
ALTER TABLE `account` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000200

-- account_gruppi
ALTER TABLE `account_gruppi`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_account`,`id_gruppo`),
    ADD KEY `id_account` (`id_account`),
    ADD KEY `id_gruppo` (`id_gruppo`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_account`,`id_gruppo`,`ordine`);

-- | 030000000201

-- account_gruppi
ALTER TABLE `account_gruppi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000300

-- account_gruppi_attribuzione
ALTER TABLE `account_gruppi_attribuzione`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_account`,`id_gruppo`,`entita`), 
    ADD KEY `id_account` (`id_account`), 
    ADD KEY `id_gruppo` (`id_gruppo`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_account`,`id_gruppo`,`ordine`,`entita`);

-- | 030000000301

-- account_gruppi_attribuzione
ALTER TABLE `account_gruppi_attribuzione` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000400

-- anagrafica
ALTER TABLE `anagrafica`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`codice`),
    ADD UNIQUE KEY `unica_persone` (`nome`,`cognome`,`codice_fiscale`),
    ADD UNIQUE KEY `unica_professionisti` (`nome`,`cognome`,`partita_iva`,`codice_fiscale`),
    ADD UNIQUE KEY `unica_aziende` (`denominazione`,`partita_iva`,`codice_fiscale`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_badge` (`id_badge`),
    ADD KEY `id_pec_sdi` (`id_pec_sdi`),
    ADD KEY `codice_archivium` (`codice_archivium`),
    ADD KEY `partita_iva` (`partita_iva`),
    ADD KEY `codice_fiscale` (`codice_fiscale`),
    ADD KEY `id_regime` (`id_regime`),
    ADD KEY `id_stato_nascita` (`id_stato_nascita`),
    ADD KEY `id_comune_nascita` (`id_comune_nascita`),
    ADD KEY `id_ranking` (`id_ranking`),    
    ADD KEY `id_agente` (`id_agente`),
    ADD KEY `id_responsabile_operativo` (`id_responsabile_operativo`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `se_importata` (`se_importata`),
    ADD KEY `se_stampa_privacy` (`se_stampa_privacy`),
    ADD KEY `data_archiviazione` (`data_archiviazione`),
    ADD KEY `indice` (`id`,`codice`,`nome`,`cognome`,`id_tipologia`,`denominazione`,`se_stampa_privacy`,`codice_fiscale`,`partita_iva`),
    ADD KEY `indice_riferimento` (`id`,`riferimento`),
    ADD KEY `indice_archiviazione` (`id`,`data_archiviazione`);

-- | 030000000401

-- anagrafica
ALTER TABLE `anagrafica` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;    

-- | 030000000500

-- anagrafica_categorie
ALTER TABLE `anagrafica_categorie`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_anagrafica`,`id_categoria`),
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_categoria` (`id_categoria`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_anagrafica`,`id_categoria`,`ordine`);

-- | 030000000501

-- anagrafica_categorie
ALTER TABLE `anagrafica_categorie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000600

-- anagrafica_certificazioni
ALTER TABLE `anagrafica_certificazioni`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_anagrafica`,`id_certificazione`, `codice`),
	ADD KEY `id_certificazione` (`id_certificazione`), 
	ADD KEY `id_anagrafica` (`id_anagrafica`), 
	ADD KEY `id_emittente` (`id_emittente`), 
	ADD KEY `nome` (`nome`), 
	ADD KEY `codice` (`codice`), 
	ADD KEY `data_emissione` (`data_emissione`), 
	ADD KEY `data_scadenza` (`data_scadenza`), 
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_anagrafica`,`id_certificazione`,`codice`, `id_emittente`, `nome`, `data_emissione`, `data_scadenza`);

-- | 030000000601

-- anagrafica_certificazioni
ALTER TABLE `anagrafica_certificazioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000900

-- anagrafica_indirizzi
ALTER TABLE `anagrafica_indirizzi`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `codice` (`codice`),
	ADD UNIQUE KEY `unica` (`id_anagrafica`,`id_indirizzo`), 
	ADD UNIQUE KEY `id_anagrafica_indirizzo` (`id_anagrafica`, `indirizzo`),
	ADD KEY `id_anagrafica` (`id_anagrafica`), 
	ADD KEY `id_indirizzo` (`id_indirizzo`), 
	ADD KEY `id_ruolo` (`id_ruolo`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_anagrafica`,`id_indirizzo`,`id_ruolo`);

-- | 030000000901

-- anagrafica_indirizzi
ALTER TABLE `anagrafica_indirizzi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000001300

-- articoli
ALTER TABLE `articoli`
    ADD PRIMARY KEY (`id`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_reparto` (`id_reparto`),
    ADD KEY `id_taglia` (`id_taglia`), 
    ADD KEY `id_colore` (`id_colore`), 
    ADD KEY `id_periodicita` (`id_periodicita`), 
    ADD KEY `id_tipologia_rinnovo` (`id_tipologia_rinnovo`), 
    ADD KEY `id_udm_dimensioni` (`id_udm_dimensioni`),
    ADD KEY `id_udm_peso` (`id_udm_peso`),
    ADD KEY `id_udm_volume` (`id_udm_volume`),
    ADD KEY `id_udm_capacita`(`id_udm_capacita`),
    ADD KEY `id_udm_durata`(`id_udm_durata`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`ordine`,`ean`,`isbn`,`id_prodotto`,`id_reparto`,`id_taglia`,`id_colore`),
    ADD KEY `indice_dimensioni` (`id`,`ordine`,`ean`,`isbn`,`id_prodotto`,`id_reparto`,`larghezza`,`lunghezza`,`altezza`,`peso`,`volume`,`capacita`);

-- | 030000001800

-- attivita
ALTER TABLE `attivita`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica_codice_archivium` (`codice_archivium`), 
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_cliente` (`id_cliente`),
    ADD KEY `id_contatto` (`id_contatto`),
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_luogo` (`id_luogo`), 
    ADD KEY `id_anagrafica_programmazione` (`id_anagrafica_programmazione`),
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_mailing` (`id_mailing`), 
    ADD KEY `id_mail` (`id_mail`), 
    ADD KEY `id_documento` (`id_documento`), 
    ADD KEY `id_pagamento` (`id_pagamento`), 
    ADD KEY `id_progetto` (`id_progetto`), 
    ADD KEY `id_matricola` (`id_matricola`),
    ADD KEY `id_todo` (`id_todo`),
    ADD KEY `id_mastro_provenienza` (`id_mastro_provenienza`), 
    ADD KEY `id_mastro_destinazione` (`id_mastro_destinazione`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `codice_archivium` (`codice_archivium`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `indice` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_contatto`,`id_progetto`,`id_todo`),
    ADD KEY `indice_scadenza` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_progetto`,`id_todo`,`data_scadenza`,`ora_scadenza`),
    ADD KEY `indice_programmazione` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_progetto`,`id_todo`,`data_programmazione`,`ora_inizio_programmazione`,`ora_fine_programmazione`),
    ADD KEY `indice_attivita` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_progetto`,`id_todo`,`data_attivita`,`ora_inizio`,`ora_fine`),
    ADD KEY `indice_mastri` (`id`,`id_tipologia`,`id_mastro_provenienza`,`id_mastro_destinazione`),
    ADD KEY `indice_sostituti` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_progetto`,`id_todo`,`timestamp_calcolo_sostituti`),
    ADD KEY `indice_token` (`id`,`token`);

-- | 030000001801

-- attivita
ALTER TABLE `attivita` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000002100

-- audio
ALTER TABLE `audio`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`path`), 
    ADD UNIQUE KEY `unica_codice_embed` (`codice_embed`), 
    ADD KEY `id_lingua` (`id_lingua`), 
    ADD KEY `id_ruolo` (`id_ruolo`), 
    ADD KEY `id_embed` (`id_embed`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_pagina` (`id_pagina`), 
    ADD KEY `id_file` (`id_file`), 
    ADD KEY `id_risorsa` (`id_risorsa`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_categoria_prodotti` (`id_categoria_prodotti`), 
    ADD KEY `id_notizia` (`id_notizia`), 
    ADD KEY `id_categoria_notizie` (`id_categoria_notizie`),
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_ruolo`,`id_lingua`,`ordine`,`path`,`codice_embed`,`id_embed`),
    ADD KEY `indice_anagrafica` (`id`,`id_ruolo`,`id_lingua`,`ordine`,`path`,`codice_embed`,`id_embed`,`id_anagrafica`),
    ADD KEY `indice_pagine` (`id`,`id_ruolo`,`id_lingua`,`ordine`,`path`,`codice_embed`,`id_embed`,`id_pagina`,`id_file`,`id_risorsa`);

-- | 030000002101

-- audio
ALTER TABLE `audio` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000002250

-- badge
ALTER TABLE `badge`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`rfid`), 
    ADD UNIQUE KEY `codice` (`id_tipologia`, `codice`), 
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_contratto` (`id_contratto`), 
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`, `id_tipologia`, `id_contratto`, `codice`, `rfid`,`nome`);

-- | 030000002251

-- badge
ALTER TABLE `badge` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000002300

-- banner
ALTER TABLE `banner`
	ADD PRIMARY KEY (`id`), 
	ADD KEY `id_tipologia` (`id_tipologia`), 
	ADD KEY `id_sito` (`id_sito`), 
	ADD KEY `ordine` (`ordine`), 
	ADD KEY `nome` (`nome`),
	ADD KEY `id_inserzionista` (`id_inserzionista`),
	ADD KEY `altezza_modulo` (`altezza_modulo`),	
	ADD KEY `larghezza_modulo` (`larghezza_modulo`),
	ADD KEY `token` (`token`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`, `id_tipologia`, `id_sito`, `ordine`,`nome`, `id_inserzionista`,`altezza_modulo`,`larghezza_modulo`, `token`);

-- | 030000002301

-- banner
ALTER TABLE `banner` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000002900

-- caratteristiche
ALTER TABLE `caratteristiche`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`nome`,`se_categorie_prodotti`,`se_prodotto`,`se_articolo`);

-- | 030000002901

-- caratteristiche
ALTER TABLE `caratteristiche` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000003000

-- carrelli
ALTER TABLE `carrelli`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`codice`),
	ADD UNIQUE KEY `session` (`session`), 
	ADD KEY `id_listino` (`id_listino`), 
	ADD KEY `fatturazione_id_tipologia_documento` (`fatturazione_id_tipologia_documento`),
	ADD KEY `intestazione_id_provincia` (`intestazione_id_provincia`), 
	ADD KEY `intestazione_id_tipologia_anagrafica` (`intestazione_id_tipologia_anagrafica`),
	ADD KEY `intestazione_id_anagrafica` (`intestazione_id_anagrafica`),
	ADD KEY `intestazione_id_account` (`intestazione_id_account`), 
	ADD KEY `intestazione_id_comune` (`intestazione_id_comune`), 
	ADD KEY `intestazione_id_stato` (`intestazione_id_stato`), 
	ADD KEY `destinatario_id_provincia` (`destinatario_id_provincia`), 
	ADD KEY `destinatario_id_stato` (`destinatario_id_stato`), 
	ADD KEY `destinatario_id_tipologia_anagrafica` (`destinatario_id_tipologia_anagrafica`),
	ADD KEY `destinatario_id_anagrafica` (`destinatario_id_anagrafica`),
	ADD KEY `destinatario_id_account` (`destinatario_id_account`),
	ADD KEY `ordine_pagamento` ( `ordine_pagamento` ),
	ADD KEY `utm_id` ( `utm_id` ),
	ADD KEY `utm_source` ( `utm_source` ),
	ADD KEY `utm_medium` ( `utm_medium` ),
	ADD KEY `utm_campaign` ( `utm_campaign` ),
	ADD KEY `utm_term` ( `utm_term` ),
	ADD KEY `utm_content` ( `utm_content` ),
	ADD KEY `id_reseller` ( `id_reseller` ),
	ADD KEY `id_affiliato` ( `id_affiliato` ),
	ADD KEY `id_affiliazione` ( `id_affiliazione` ),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_listino`,`prezzo_netto_totale`,`prezzo_lordo_totale`,`sconto_percentuale`,`sconto_valore`,`prezzo_netto_finale`,`prezzo_lordo_finale`,`provider_checkout`,`timestamp_checkout`,`provider_pagamento`,`timestamp_pagamento`,`codice_pagamento`,`status_pagamento`,`importo_pagamento`,`intestazione_id_anagrafica`);

-- | 030000003001

-- carrelli
ALTER TABLE `carrelli` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000003050

-- carrelli_articoli
ALTER TABLE `carrelli_articoli`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `unica` (`id_carrello`,`id_articolo`,`destinatario_id_anagrafica`),
	ADD KEY `id_carrello` (`id_carrello`),  
	ADD KEY `id_articolo` (`id_articolo`),  
	ADD KEY `destinatario_id_anagrafica` (`destinatario_id_anagrafica`),
	ADD KEY `id_rinnovo` (`id_rinnovo`),
	ADD KEY `id_iva` (`id_iva`),
	ADD KEY `id_pagamento` (`id_pagamento`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`, `id_carrello`, `id_articolo`, `id_iva`, `prezzo_netto_unitario`, `prezzo_lordo_unitario`,`quantita`, `prezzo_netto_totale`,  `prezzo_lordo_totale`, `sconto_percentuale`, `sconto_valore`, `prezzo_netto_finale`,  `prezzo_lordo_finale`);

-- | 030000003051

-- carrelli_articoli
ALTER TABLE `carrelli_articoli` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000003100

-- categorie_anagrafica
-- TODO: riordinare i flag in ordine alfabetico
ALTER TABLE `categorie_anagrafica`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_genitore` (`id_genitore`), 
    ADD KEY `se_lead` (`se_lead`), 
    ADD KEY `se_prospect` (`se_prospect`), 
    ADD KEY `se_cliente` (`se_cliente`), 
    ADD KEY `se_fornitore` (`se_fornitore`), 
    ADD KEY `se_produttore` (`se_produttore`), 
    ADD KEY `se_collaboratore` (`se_collaboratore`), 
    ADD KEY `se_interno` (`se_interno`), 
    ADD KEY `se_esterno` (`se_esterno`), 
    ADD KEY `se_commerciale` (`se_commerciale`), 
    ADD KEY `se_concorrente` (`se_concorrente`), 
    ADD KEY `se_gestita` (`se_gestita`), 
    ADD KEY `se_amministrazione` (`se_amministrazione`), 
    ADD KEY `se_notizie` (`se_notizie`), 
    ADD KEY `se_corriere` (`se_corriere`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`se_lead`,`se_prospect`,`se_cliente`,`se_fornitore`,`se_produttore`,`se_collaboratore`,`se_interno`,`se_esterno`,`se_commerciale`,`se_concorrente`,`se_gestita`,`se_amministrazione`);

-- | 030000003101

-- categorie_anagrafica
ALTER TABLE `categorie_anagrafica` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000003700

-- categorie_notizie
ALTER TABLE `categorie_notizie`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD UNIQUE KEY `codice` (`codice`),
	ADD KEY `id_genitore` (`id_genitore`), 
	ADD KEY `id_sito` (`id_sito`), 
	ADD KEY `id_pagina` (`id_pagina`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`id_sito`,`id_pagina`);

-- | 030000003701

-- categorie_notizie
ALTER TABLE `categorie_notizie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000003900

-- categorie_prodotti
ALTER TABLE `categorie_prodotti`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_sito` (`id_sito`), 
    ADD KEY `id_pagina` (`id_pagina`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`id_sito`,`id_pagina`);

-- | 030000003901

-- categorie_prodotti
ALTER TABLE `categorie_prodotti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000004300

-- categorie_progetti
ALTER TABLE `categorie_progetti`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `se_sitemap` (`se_sitemap`),
    ADD KEY `se_cacheable` (`se_cacheable`),
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `id_pagina` (`id_pagina`),
    ADD KEY `se_ordinario`(`se_ordinario`),
    ADD KEY `se_straordinario`(`se_straordinario`),
    ADD KEY `se_disciplina`(`se_disciplina`),
    ADD KEY `se_classe`(`se_classe`),    
    ADD KEY `se_fascia` (`se_fascia`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`, `id_sito`);

-- | 030000004301

-- categorie_progetti
ALTER TABLE `categorie_progetti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000004500

-- categorie_risorse
ALTER TABLE `categorie_risorse`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD UNIQUE KEY `codice` (`codice`),
	ADD KEY `id_genitore` (`id_genitore`),
	ADD KEY `id_sito` (`id_sito`),
	ADD KEY `id_pagina` (`id_pagina`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`id_pagina`);

-- | 030000004501

-- categorie_risorse
ALTER TABLE `categorie_risorse` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000004600

-- causali
ALTER TABLE `causali`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`nome`),
	ADD KEY `nome` (`nome`),
	ADD KEY `se_trasporto` (`se_trasporto`), 
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`nome`,`se_trasporto`);

-- | 030000004601

-- causali
ALTER TABLE `causali` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000004700

-- certificazioni
ALTER TABLE `certificazioni`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `unica` (`nome`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`nome`); 

-- | 030000004701

-- certificazioni
ALTER TABLE `certificazioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT; 

-- | 030000005000

-- classi_energetiche
ALTER TABLE `classi_energetiche`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `nome` (`nome`);

-- | 030000005001

-- classi_energetiche
ALTER TABLE `classi_energetiche` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000005100

-- colori
ALTER TABLE `colori`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_hex` (`nome`,`hex`),
    ADD UNIQUE KEY `unica_rgb` (`nome`,`r`,`g`,`b`),
    ADD UNIQUE KEY `unica_ral` (`nome`,`ral`),
    ADD UNIQUE KEY `unica_pantone` (`nome`,`pantone`),
    ADD UNIQUE KEY `unica_cmyk` (`nome`,`c`,`m`,`y`,`k`),
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `indice` (`id`, `nome`,`id_genitore`,`hex`,`r`,`g`,`b`),
    ADD KEY `indice_ral` (`id`, `nome`,`id_genitore`,`ral`),
    ADD KEY `indice_pantone` (`id`, `nome`,`id_genitore`,`pantone`),
    ADD KEY `indice_cmyk` (`id`, `nome`,`id_genitore`,`c`,`m`,`y`,`k`);

-- | 030000005101

-- colori
ALTER TABLE `colori` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000005300

-- comuni
ALTER TABLE `comuni`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica_istat` (`codice_istat`),
    ADD UNIQUE KEY `unica_catasto` (`codice_catasto`),
    ADD KEY `id_provincia` (`id_provincia`),
    ADD KEY `indice` (`id`,`id_provincia`, `nome`,`codice_istat`,`codice_catasto`);

-- | 030000005301

-- comuni
ALTER TABLE `comuni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000006000

-- condizioni
ALTER TABLE `condizioni`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unico` (`nome`),
	ADD KEY `nome` (`nome`),
	ADD KEY `se_catalogo` (`se_catalogo`),
	ADD KEY `se_immobili` (`se_immobili`);
	

-- | 030000006001

-- condizioni
ALTER TABLE `condizioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000006200

-- condizioni_pagamento
ALTER TABLE `condizioni_pagamento`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unico` (`codice`,`nome`),
	ADD KEY `codice` (`codice`),
	ADD KEY `nome` (`nome`);

-- | 030000006201

-- condizioni_pagamento
ALTER TABLE `condizioni_pagamento` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000006700

-- contatti
ALTER TABLE `contatti`
    ADD PRIMARY KEY (`id`), 
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_inviante` (`id_inviante`),
    ADD KEY `id_ranking` (`id_ranking`),    
    ADD KEY `utm_id` ( `utm_id` ),
    ADD KEY `utm_source` ( `utm_source` ),
    ADD KEY `utm_medium` ( `utm_medium` ),
    ADD KEY `utm_campaign` ( `utm_campaign` ),
    ADD KEY `utm_term` ( `utm_term` ),
    ADD KEY `utm_content` ( `utm_content` ),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `timestamp_contatto` (`timestamp_contatto`), 
    ADD KEY `indice` (`id`, `id_tipologia`, `id_anagrafica`,`id_inviante`,`id_ranking`,`nome`,`timestamp_contatto`);

-- | 030000006701

-- contatti
ALTER TABLE `contatti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000006900

-- contenuti
ALTER TABLE `contenuti`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_anagrafica` (`id_lingua`,`id_anagrafica`), 
    ADD UNIQUE KEY `unica_prodotto` (`id_lingua`,`id_prodotto`), 
    ADD UNIQUE KEY `unica_articolo` (`id_lingua`,`id_articolo`), 
    ADD UNIQUE KEY `unica_categoria_prodotti` (`id_lingua`,`id_categoria_prodotti`), 
    ADD UNIQUE KEY `unica_caratteristica` (`id_lingua`,`id_caratteristica`), 
    ADD UNIQUE KEY `unica_marchio` (`id_lingua`,`id_marchio`), 
    ADD UNIQUE KEY `unica_file` (`id_lingua`,`id_file`), 
    ADD UNIQUE KEY `unica_immagine` (`id_lingua`,`id_immagine`), 
    ADD UNIQUE KEY `unica_video` (`id_lingua`,`id_video`), 
    ADD UNIQUE KEY `unica_audio` (`id_lingua`,`id_audio`), 
    ADD UNIQUE KEY `unica_risorsa` (`id_lingua`,`id_risorsa`), 
    ADD UNIQUE KEY `unica_categoria_risorse` (`id_lingua`,`id_categoria_risorse`), 
    ADD UNIQUE KEY `unica_pagina` (`id_lingua`,`id_pagina`), 
    ADD UNIQUE KEY `unica_popup` (`id_lingua`,`id_popup`), 
    ADD UNIQUE KEY `unica_indirizzo` (`id_lingua`,`id_indirizzo`), 
    ADD UNIQUE KEY `unica_notizia` (`id_lingua`,`id_notizia`), 
    ADD UNIQUE KEY `unica_categoria_notizie` (`id_lingua`,`id_categoria_notizie`), 
    ADD UNIQUE KEY `unica_template` (`id_lingua`,`id_template`), 
    ADD UNIQUE KEY `unica_colore` (`id_lingua`,`id_colore`),
    ADD UNIQUE KEY `unica_banner` (`id_lingua`,`id_banner`), 
    ADD KEY `id_lingua` (`id_lingua`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_categoria_prodotti` (`id_categoria_prodotti`), 
    ADD KEY `id_caratteristica` (`id_caratteristica`), 
    ADD KEY `id_marchio` (`id_marchio`), 
    ADD KEY `id_file` (`id_file`), 
    ADD KEY `id_immagine` (`id_immagine`), 
    ADD KEY `id_video` (`id_video`), 
    ADD KEY `id_audio` (`id_audio`), 
    ADD KEY `id_risorsa` (`id_risorsa`),
    ADD KEY `id_categoria_risorse` (`id_categoria_risorse`),
    ADD KEY `id_pagina` (`id_pagina`), 
    ADD KEY `id_popup` (`id_popup`), 
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`),     
    ADD KEY `id_notizia` (`id_notizia`), 
    ADD KEY `id_categoria_notizie` (`id_categoria_notizie`),
    ADD KEY `id_template` (`id_template`), 
    ADD KEY `id_mailing` (`id_mailing`),
    ADD KEY `id_colore` (`id_colore`), 
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `id_banner` (`id_banner`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_lingua`),
    ADD KEY `indice_anagrafica` (`id`,`id_lingua`,`id_anagrafica`),
    ADD KEY `indice_prodotti` (`id`,`id_lingua`,`id_prodotto`,`id_articolo`,`id_categoria_prodotti`,`id_marchio`),
    ADD KEY `indice_immagini` (`id`,`id_lingua`,`id_immagine`),
    ADD KEY `indice_file` (`id`,`id_lingua`,`id_file`),
    ADD KEY `indice_risorse` (`id`,`id_lingua`,`id_risorsa`,`id_categoria_risorse`),
    ADD KEY `indice_pagine` (`id`,`id_lingua`,`id_pagina`,`id_popup`),
    ADD KEY `indice_notizie` (`id`,`id_lingua`,`id_notizia`,`id_categoria_notizie`),
    ADD KEY `indice_video` (`id`,`id_lingua`,`id_video`),
    ADD KEY `indice_audio` (`id`,`id_lingua`,`id_audio`),
    ADD KEY `indice_template` (`id`,`id_lingua`,`id_template`),
    ADD KEY `indice_colore` (`id`,`id_lingua`,`id_colore`);

-- | 030000006901

-- contenuti
ALTER TABLE `contenuti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000007100

-- continenti
ALTER TABLE `continenti`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `indice` (`id`,`codice`,`nome`);

-- | 030000007101

-- continenti
ALTER TABLE `continenti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000007200

-- contratti
ALTER TABLE `contratti`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `codice` ( `codice` ),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_progetto`),
    ADD KEY `id_badge` (`id_badge`),
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `codice_affiliazione` ( `codice_affiliazione` ),
    ADD KEY `indice` ( `id_tipologia`, `codice`, `codice_affiliazione`, `nome`, `id_progetto`, `id_immobile`);

-- | 030000007201

-- contratti
ALTER TABLE `contratti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000007300

-- contratti_anagrafica
ALTER TABLE `contratti_anagrafica`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_contratto`,`id_anagrafica`,`id_ruolo`), 
    ADD KEY `id_contratto` (`id_contratto`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_ruolo` (`id_ruolo`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_contratto`,`id_anagrafica`,`id_ruolo`,`ordine`);

-- | 030000007301

-- contratti_anagrafica
ALTER TABLE `contratti_anagrafica` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000008000

-- coupon
ALTER TABLE `coupon`
	ADD PRIMARY KEY (`id`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`nome`,`timestamp_inizio`,`timestamp_fine`,`sconto_percentuale`,`sconto_fisso`,`se_multiuso`,`se_globale`);

-- | 030000009000

-- disponibilita
ALTER TABLE `disponibilita`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unico` (`nome`),
	ADD KEY `nome` (`nome`),
	ADD KEY `se_catalogo` (`se_catalogo`),
	ADD KEY `se_immobili` (`se_immobili`);
	
-- | 030000009001

-- disponibilita
ALTER TABLE `disponibilita` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000009800

-- documenti
ALTER TABLE `documenti`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_tipologia`,`numero`,`sezionale`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD UNIQUE KEY `unica_codice_archivium` (`codice_archivium`),
    ADD UNIQUE KEY `unica_codice_sdi` (`codice_sdi`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_emittente` (`id_emittente`), 
    ADD KEY `id_sede_emittente` (`id_sede_emittente`), 
    ADD KEY `id_destinatario` (`id_destinatario`), 
    ADD KEY `id_sede_destinatario` (`id_sede_destinatario`), 
    ADD KEY `id_condizione_pagamento` (`id_condizione_pagamento`),
    ADD KEY `id_coupon` (`id_coupon`),
    ADD KEY `id_mastro_provenienza` (`id_mastro_provenienza`), 
    ADD KEY `id_mastro_destinazione` (`id_mastro_destinazione`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `cig` (`cig`),
    ADD KEY `cup` (`cup`),
    ADD KEY `id_causale` (`id_causale`),
    ADD KEY `id_trasportatore` (`id_trasportatore`),
    ADD KEY `porto` (`porto`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_tipologia`,`numero`,`sezionale`,`data`,`id_emittente`,`id_sede_emittente`,`id_destinatario`,`id_sede_destinatario`,`id_coupon`);

-- | 030000009801

-- documenti
ALTER TABLE `documenti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000012000

-- edifici
ALTER TABLE `edifici`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_indirizzo` (`id_indirizzo`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`, `id_tipologia`, `id_indirizzo`, `nome`, `codice`);

-- | 030000012001

-- edifici
ALTER TABLE `edifici`  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000012800

-- embed
ALTER TABLE `embed`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `nome` (`nome`), 
	ADD KEY `indice` (`id`,`nome`,`se_audio`,`se_video`);

-- | 030000012801

-- embed
ALTER TABLE `embed` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015000

-- file
ALTER TABLE `file`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_anagrafica` (`id_anagrafica`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_prodotto` (`id_prodotto`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_articolo` (`id_articolo`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_categoria_prodotti` (`id_categoria_prodotti`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_todo` (`id_todo`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_pagina` (`id_pagina`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_template` (`id_template`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_notizia` (`id_notizia`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_categoria_notizie` (`id_categoria_notizie`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_risorsa` (`id_risorsa`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_categoria_risorse` (`id_categoria_risorse`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_mailing` (`id_mailing`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_mail_out` (`id_mail_out`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_mail_sent` (`id_mail_sent`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_progetto` (`id_progetto`,`id_ruolo`,`path`),
    ADD UNIQUE KEY `unica_categoria_progetti` (`id_categoria_progetti`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_documento` (`id_documento`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_indirizzo` (`id_indirizzo`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_edificio` (`id_edificio`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_immobile` (`id_immobile`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_contratto` (`id_contratto`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_valutazione` (`id_valutazione`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_rinnovo` (`id_rinnovo`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_anagrafica_certificazioni` (`id_anagrafica_certificazioni`,`id_ruolo`,`path`),     
    ADD UNIQUE KEY `unica_valutazione_certificazioni` (`id_valutazione_certificazioni`,`id_ruolo`,`path`), 
    ADD UNIQUE KEY `unica_licenza` (`id_licenza`,`id_ruolo`,`path`),
    ADD KEY `id_ruolo` (`id_ruolo`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_categoria_prodotti` (`id_categoria_prodotti`), 
    ADD KEY `id_todo` (`id_todo`), 
    ADD KEY `id_pagina` (`id_pagina`), 
    ADD KEY `id_template` (`id_template`), 
    ADD KEY `id_mailing` (`id_mailing`),
    ADD KEY `id_notizia` (`id_notizia`), 
    ADD KEY `id_categoria_notizie` (`id_categoria_notizie`), 
    ADD KEY `id_risorsa` (`id_risorsa`),
    ADD KEY `id_categoria_risorse` (`id_categoria_risorse`), 
    ADD KEY `id_lingua` (`id_lingua`), 
    ADD KEY `id_mail_out` (`id_mail_out`), 
    ADD KEY `id_mail_sent` (`id_mail_sent`), 
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `id_documento` (`id_documento`),
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `id_contratto` (`id_contratto`), 
    ADD KEY `id_valutazione` (`id_valutazione`), 
    ADD KEY `id_rinnovo` (`id_rinnovo`),
    ADD KEY `id_anagrafica_certificazioni` (`id_anagrafica_certificazioni`),
    ADD KEY `id_valutazione_certificazioni` (`id_valutazione_certificazioni`),
    ADD KEY `id_licenza` (`id_licenza`),
    ADD KEY `id_attivita` (`id_attivita`),
    ADD KEY `path` (`path`), 
    ADD KEY `url` (`url`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_ruolo`,`id_lingua`,`path`,`url`);

-- | 030000015001

-- file
ALTER TABLE `file` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015100

-- funnel
ALTER TABLE `funnel`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`nome`), 
	ADD KEY `nome` (`nome`), 
	ADD KEY `indice` (`id`,`nome`);

-- | 030000015101

-- funnel
ALTER TABLE `funnel` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015200

-- gruppi
ALTER TABLE `gruppi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `nome` (`nome`),
    ADD KEY `id_genitore` (`id_genitore`), 
    ADD KEY `id_organizzazione` (`id_organizzazione`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_genitore`,`id_organizzazione`,`nome`);

-- | 030000015201

-- gruppi
ALTER TABLE `gruppi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015400

-- iban
ALTER TABLE `iban`
	ADD PRIMARY KEY (`id`), 
	ADD KEY `id_anagrafica` (`id_anagrafica`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_anagrafica`,`iban`);

-- | 030000015401

-- iban
ALTER TABLE `iban` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015600

-- immagini
ALTER TABLE `immagini`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_anagrafica` (`id_anagrafica`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_pagina` (`id_pagina`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_file` (`id_file`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_prodotto` (`id_prodotto`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_articolo` (`id_articolo`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_categoria_prodotti` (`id_categoria_prodotti`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_risorse` (`id_risorsa`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_categoria_risorse` (`id_categoria_risorse`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_notizie` (`id_notizia`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_categoria_notizie` (`id_categoria_notizie`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_indirizzi` (`id_indirizzo`,`id_ruolo`,`id_lingua`,`path`), 
    ADD UNIQUE KEY `unica_banner` (`id_banner`,`id_ruolo`,`id_lingua`,`path`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_pagina` (`id_pagina`), 
    ADD KEY `id_file` (`id_file`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_categoria_prodotti` (`id_categoria_prodotti`), 
    ADD KEY `id_risorsa` (`id_risorsa`),
    ADD KEY `id_categoria_risorse` (`id_categoria_risorse`), 
    ADD KEY `id_notizia` (`id_notizia`), 
    ADD KEY `id_categoria_notizie` (`id_categoria_notizie`), 
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `id_contratto` (`id_contratto`), 
    ADD KEY `id_valutazione` (`id_valutazione`), 
    ADD KEY `id_rinnovo` (`id_rinnovo`), 
    ADD KEY `id_lingua` (`id_lingua`), 
    ADD KEY `id_ruolo` (`id_ruolo`), 
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `id_banner` (`id_banner`), 
    ADD KEY `path` (`path`), 
    ADD KEY `path_alternativo` (`path_alternativo`), 
    ADD KEY `token` (`token`), 
    ADD KEY `timestamp_scalamento` (`timestamp_scalamento`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_anagrafica` (`id`,`id_anagrafica`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_pagine` (`id`,`id_pagina`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_file` (`id`,`id_file`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_prodotti` (`id`,`id_prodotto`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_articoli` (`id`,`id_articolo`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_categorie_prodotti` (`id`,`id_categoria_prodotti`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_risorse` (`id`,`id_risorsa`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_categorie_risorse` (`id`,`id_categoria_risorse`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_notizie` (`id`,`id_notizia`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_categorie_notizie` (`id`,`id_categoria_notizie`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`),
    ADD KEY `indice_indirizzi` (`id`,`id_indirizzo`,`id_lingua`,`id_ruolo`,`ordine`,`path`,`path_alternativo`,`token`,`timestamp_scalamento`);

-- | 030000015601

-- immagini
ALTER TABLE `immagini` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015700

-- immobili
ALTER TABLE `immobili`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_tipologia`,`id_edificio`, `scala`,  `piano`, `interno`, `nome`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_edificio` (`id_edificio`),
    ADD KEY `nome` (`nome`),
    ADD KEY `scala` (`scala`),
    ADD KEY `piano` (`piano`),
    ADD KEY `interno` (`interno`),
    ADD KEY `catasto_foglio` (`catasto_foglio`),
    ADD KEY `catasto_particella` (`catasto_particella`),
    ADD KEY `catasto_sub` (`catasto_sub`),
    ADD KEY `catasto_categoria` (`catasto_categoria`),
    ADD KEY `catasto_classe` (`catasto_classe`),
    ADD KEY `catasto_consistenza` (`catasto_consistenza`),
    ADD KEY `catasto_superficie` (`catasto_superficie`),
    ADD KEY `catasto_rendita` (`catasto_rendita`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`);

-- | 030000015701

-- immobili
ALTER TABLE `immobili`  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000015800

-- indirizzi
ALTER TABLE `indirizzi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_comune`,`indirizzo`,`civico`,`cap`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_comune` (`id_comune`), 
    ADD KEY `timestamp_geolocalizzazione` (`timestamp_geolocalizzazione`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_comune`,`indirizzo`,`civico`,`cap`,`timestamp_geolocalizzazione`);

-- | 030000015801

-- indirizzi
ALTER TABLE `indirizzi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000016000

-- iva
ALTER TABLE `iva`
    ADD PRIMARY KEY (`id`),
    ADD KEY `aliquota` (`aliquota`),
    ADD KEY `timestamp_archiviazione` (`timestamp_archiviazione`),
    ADD KEY `indice` (`id`,`aliquota`,`nome`,`codice`,`timestamp_archiviazione`);

-- | 030000016001

-- iva
ALTER TABLE `iva` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000016600

-- licenze
ALTER TABLE `licenze`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `nome` (`nome`),
    ADD KEY `giorni_validita` (`giorni_validita`),
    ADD KEY `giorni_rinnovo` (`giorni_rinnovo`),
    ADD KEY `timestamp_distribuzione` (`timestamp_distribuzione`),
    ADD KEY `timestamp_inizio` (`timestamp_inizio`),
    ADD KEY `timestamp_fine` (`timestamp_fine`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id_anagrafica`,`id_tipologia`,`id_rivenditore`,`codice`,`postazioni`,`nome`,`giorni_validita`,`giorni_rinnovo`,`timestamp_distribuzione`,`timestamp_inizio`,`timestamp_fine`);

-- | 030000016601

-- licenze
ALTER TABLE `licenze` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000016800

-- lingue
ALTER TABLE `lingue`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica_nome` (`nome`),
    ADD UNIQUE KEY `unica_iso6391alpha2` (`iso6391alpha2`),
    ADD UNIQUE KEY `unica_iso6393alpha3` (`iso6393alpha3`),
    ADD UNIQUE KEY `unica_ietf` (`ietf`),
    ADD KEY `indice` (`id`,`nome`,`iso6391alpha2`,`iso6393alpha3`,`ietf`);

-- | 030000016801

-- lingue
ALTER TABLE `lingue` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000017200

-- listini
ALTER TABLE `listini`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_valuta`,`nome`),
    ADD KEY `id_valuta` (`id_valuta`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_valuta`,`nome`);

-- | 030000017201

-- listini
ALTER TABLE `listini` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000018000

-- luoghi
ALTER TABLE `luoghi`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_indirizzo` (`id_indirizzo`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`), 
    ADD KEY `url` (`url`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`id_indirizzo`,  `id_tipologia`,`id_edificio`, `id_immobile`,`nome`);

-- | 030000018001

-- luoghi
ALTER TABLE `luoghi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000018600

-- mail
ALTER TABLE `mail`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_anagrafica`,`indirizzo`),
    ADD KEY `id_ruolo` (`id_ruolo`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_anagrafica`,`indirizzo`,`se_notifiche`,`se_pec`);

-- | 030000018601

-- mail
ALTER TABLE `mail` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000018800

-- mail_out
ALTER TABLE `mail_out`
	ADD PRIMARY KEY (`id`), 
  	ADD UNIQUE KEY `unica` (`id_mail`,`id_mailing`),
	ADD KEY `id_mail` (`id_mail`), 
	ADD KEY `id_mailing` (`id_mailing`), 
	ADD KEY `timestamp_composizione` (`timestamp_composizione`), 
	ADD KEY `timestamp_invio` (`timestamp_invio`), 
	ADD KEY `token` (`token`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 	
	ADD KEY `indice` (`id`,`id_mail`,`id_mailing`,`timestamp_composizione`,`timestamp_invio`,`token`,`tentativi`);

-- | 030000018801

-- mail_out
ALTER TABLE `mail_out` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000018900

-- mail_sent
ALTER TABLE `mail_sent`
	ADD PRIMARY KEY (`id`), 
  	ADD UNIQUE KEY `unica` (`id_mail`,`id_mailing`),
	ADD KEY `id_mail` (`id_mail`), 
	ADD KEY `id_mailing` (`id_mailing`), 
	ADD KEY `timestamp_composizione` (`timestamp_composizione`), 
	ADD KEY `timestamp_invio` (`timestamp_invio`), 
	ADD KEY `token` (`token`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 	
	ADD KEY `indice` (`id`,`id_mail`,`id_mailing`,`timestamp_composizione`,`timestamp_invio`,`token`,`tentativi`);

-- | 030000018901

-- mail_sent
ALTER TABLE `mail_sent` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000019000

-- mailing
ALTER TABLE `mailing`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`nome`);

-- | 030000019001

-- mailing
ALTER TABLE `mailing` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000020200

-- marchi
ALTER TABLE `marchi`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`nome`);

-- | 030000020201

-- marchi
ALTER TABLE `marchi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000020600

-- mastri
ALTER TABLE `mastri`
     ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
     ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_anagrafica_indirizzi` (`id_anagrafica_indirizzi`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_account` (`id_account`),
    ADD KEY `id_progetto` (`id_progetto`),
     ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
     ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_genitore`,`id_tipologia`,`nome`);

-- | 030000020601

-- mastri
ALTER TABLE `mastri` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000021000

-- matricole
ALTER TABLE `matricole`
     ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica_scadenza` (`id_articolo`,`data_scadenza`),
      ADD KEY `id_account_inserimento` (`id_account_inserimento`),
      ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `matricola` (`matricola`),
      ADD KEY `id_marchio` (`id_marchio`),
      ADD KEY `id_produttore` (`id_produttore`),
    ADD KEY `id_articolo` (`id_articolo` ),
      ADD KEY `indice` (`id`,`id_marchio`,`id_produttore`,`matricola`,`nome`);

-- | 030000021001

-- matricole
ALTER TABLE `matricole` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000021900

-- modalita_pagamento
ALTER TABLE `modalita_pagamento`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `nome` (`nome`,`codice`),
	ADD KEY `indice` (`id`,`nome`,`provider`,`codice`);

-- | 030000021901

-- modalita_pagamento
ALTER TABLE `modalita_pagamento` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000022000

-- notizie
ALTER TABLE `notizie`
	ADD PRIMARY KEY (`id`), 
	ADD KEY `id_tipologia` (`id_tipologia`),
	ADD KEY `id_sito` (`id_sito`),
	ADD KEY `se_sitemap` (`se_sitemap`),
	ADD KEY `se_cacheable` (`se_cacheable`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_tipologia`,`nome`, `id_sito`);

-- | 030000022001

-- notizie
ALTER TABLE `notizie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000022200

-- notizie_categorie
ALTER TABLE `notizie_categorie`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_notizia`,`id_categoria`),
	ADD KEY `id_notizia` (`id_notizia`), 
	ADD KEY `id_categoria` (`id_categoria`), 
	ADD KEY `ordine` (`ordine`), 
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_notizia`,`id_categoria`,`ordine`);

-- | 030000022201

-- notizie_categorie
ALTER TABLE `notizie_categorie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000022800

-- organizzazioni
ALTER TABLE `organizzazioni`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_genitore`,`id_anagrafica`,`id_ruolo`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_ruolo` (`id_ruolo`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`id_anagrafica`,`id_ruolo`);

-- | 030000022801

-- organizzazioni
ALTER TABLE `organizzazioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000023100

-- pagamenti
ALTER TABLE `pagamenti`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_documento`,`data_scadenza`,`nome`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_modalita_pagamento` (`id_modalita_pagamento`),
    ADD KEY `ordine` (`ordine`), 
    ADD KEY `id_documento` (`id_documento`), 
    ADD KEY `id_carrelli_articoli` (`id_carrelli_articoli`), 
    ADD KEY `id_creditore` (`id_creditore`), 
    ADD KEY `id_debitore` (`id_debitore`), 
    ADD KEY `id_mastro_provenienza` (`id_mastro_provenienza`), 
    ADD KEY `id_mastro_destinazione` (`id_mastro_destinazione`), 
    ADD KEY `id_iban` (`id_iban`), 
    ADD KEY `id_listino` (`id_listino`), 
    ADD KEY `timestamp_pagamento` (`timestamp_pagamento`), 
    ADD KEY `data_scadenza` (`data_scadenza`), 
    ADD KEY `importo_lordo_totale` (`importo_lordo_totale`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_tipologia`,`ordine`,`id_documento`,`timestamp_pagamento`,`id_mastro_provenienza`,`id_mastro_destinazione`,`id_listino`,`id_iban`,`importo_lordo_totale`);

-- | 030000023101

-- pagamenti
ALTER TABLE `pagamenti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000023200

-- pagine
ALTER TABLE `pagine`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_contenuti` (`id_contenuti`),
    ADD KEY `se_sitemap` (`se_sitemap`),
    ADD KEY `se_cacheable` (`se_cacheable`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`id_sito`,`nome`,`template`,`schema_html`,`tema_css`,`se_sitemap`,`se_cacheable`,`id_contenuti`);

-- | 030000023201

-- pagine
ALTER TABLE `pagine` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000023500

-- periodi
ALTER TABLE `periodi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` ( `data_inizio`, `data_fine`, `nome`, `id_genitore`),
    ADD    KEY `id_genitore` (`id_genitore`),
    ADD    KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` ( `id`, `id_genitore`, `data_inizio`, `data_fine`, `nome`,`id_tipologia`);

-- | 030000023501

-- periodi
ALTER TABLE `periodi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000023600

-- periodicita
ALTER TABLE `periodicita`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`), 
    ADD KEY `giorni` (`giorni`), 
    ADD KEY `nome` (`nome`), 
    ADD KEY `indice` (`id`,`nome`);

-- | 030000023601

-- periodicita
ALTER TABLE `periodicita` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000023800

-- pianificazioni
ALTER TABLE `pianificazioni`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `id_progetto` (`id_progetto`), 
    ADD KEY `id_todo` (`id_todo`), 
    ADD KEY `id_attivita` (`id_attivita`), 
    ADD KEY `id_contratto` (`id_contratto`),
    ADD KEY `id_periodicita` (`id_periodicita`),
    ADD KEY `nome` (`nome`), 
    ADD KEY `token` (`token`), 
    ADD KEY `data_fine` (`data_fine`),
    ADD KEY `data_inizio` (`data_inizio`),
    ADD KEY `data_elaborazione` (`data_elaborazione`),
    ADD KEY `timestamp_elaborazione` (`timestamp_elaborazione`),
    ADD KEY `entita` (`entita`),
    ADD KEY `model_id_luogo` (`model_id_luogo`),
    ADD KEY `model_id_anagrafica`  (`model_id_anagrafica`),
    ADD KEY `model_id_anagrafica_programmazione`  (`model_id_anagrafica_programmazione`),
    ADD KEY `model_id_articolo`  (`model_id_articolo`),
    ADD KEY `model_id_attivita`  (`model_id_attivita`),
    ADD KEY `model_id_cliente`  (`model_id_cliente`),
    ADD KEY `model_id_condizione_pagamento`  (`model_id_condizione_pagamento`),
    ADD KEY `model_id_contatto`  (`model_id_contatto`),
    ADD KEY `model_id_coupon`  (`model_id_coupon`),
    ADD KEY `model_id_destinatario`  (`model_id_destinatario`),
    ADD KEY `model_id_documento`  (`model_id_documento`), 
    ADD KEY `model_id_emittente`  (`model_id_emittente`),
    ADD KEY `model_id_genitore`  (`model_id_genitore`),
    ADD KEY `model_id_iban`  (`model_id_iban`),
    ADD KEY `model_id_indirizzo`  (`model_id_indirizzo`),
    ADD KEY `model_id_immobile`  (`model_id_immobile`),
    ADD KEY `model_id_licenza`  (`model_id_licenza`),
    ADD KEY `model_id_listino`  (`model_id_listino`),
    ADD KEY `model_id_mastro_destinazione`  (`model_id_mastro_destinazione`),
    ADD KEY `model_id_mastro_provenienza`  (`model_id_mastro_provenienza`),
    ADD KEY `model_id_matricola`  (`model_id_matricola`),
    ADD KEY `model_id_modalita_pagamento`  (`model_id_modalita_pagamento`),
    ADD KEY `model_id_prodotto`  (`model_id_prodotto`),
    ADD KEY `model_id_progetto`  (`model_id_progetto`),
    ADD KEY `model_id_reparto`  (`model_id_reparto`),
    ADD KEY `model_id_tipologia`  (`model_id_tipologia`),
    ADD KEY `model_id_todo`  (`model_id_todo`),
    ADD KEY `model_id_trasportatore`  (`model_id_trasportatore`),
    ADD KEY `model_id_udm`  (`model_id_udm`),
    ADD KEY `model_anno_programmazione`  (`model_anno_programmazione`),
    ADD KEY `model_codice`  (`model_codice`),
    ADD KEY `model_data`  (`model_data`),
    ADD KEY `model_data_fine`  (`model_data_fine`),
    ADD KEY `model_data_inizio`  (`model_data_inizio`),
    ADD KEY `model_data_programmazione`  (`model_data_programmazione`),
    ADD KEY `model_importo_netto_totale`  (`model_importo_netto_totale`),
    ADD KEY `model_nome`  (`model_nome`),
    ADD KEY `model_ore_programmazione` (`model_ore_programmazione`),
    ADD KEY `model_quantita`  (`model_quantita`),
    ADD KEY `model_sconto_percentuale`  (`model_sconto_percentuale`),
    ADD KEY `model_sconto_valore`  (`model_sconto_valore`),
    ADD KEY `model_se_automatico`  (`model_se_automatico`),
    ADD KEY `model_sezionale`  (`model_sezionale`),
    ADD KEY `model_settimana_programmazione`  (`model_settimana_programmazione`),
    ADD KEY `model_data_scadenza`  (`model_data_scadenza`),
    ADD KEY `indice` (`id`,`nome`,`id_periodicita`,`cadenza`,`se_lunedi`,`se_martedi`,`se_mercoledi`,`se_giovedi`,`se_venerdi`,`se_sabato`,`se_domenica`,`schema_ripetizione`,`data_elaborazione`,`giorni_estensione`,`data_fine`,`token`);

-- | 030000023801

-- pianificazioni
ALTER TABLE `pianificazioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000024000

-- popup
ALTER TABLE `popup`
	ADD PRIMARY KEY (`id`), 
	ADD KEY `id_tipologia` (`id_tipologia`), 
	ADD KEY `id_sito` (`id_sito`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_tipologia`,`id_sito`,`nome`,`html_id`,`html_class`,`html_class_attivazione`,`n_scroll`,`n_secondi`,`template`,`schema_html`,`se_ovunque`);

-- | 030000024001

-- popup
ALTER TABLE `popup` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000025000

-- prezzi
ALTER TABLE `prezzi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_prodotto` (`id_prodotto`,`id_listino`,`id_iva`), 
    ADD UNIQUE KEY `unica_articolo` (`id_articolo`,`id_listino`,`id_iva`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_listino` (`id_listino`),
    ADD KEY `id_iva` (`id_iva`),
    ADD KEY `prezzo` (`prezzo`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_prodotto`,`id_articolo`,`prezzo`,`id_listino`,`id_iva`),
    ADD KEY `indice_prodotti` (`id`,`id_prodotto`,`prezzo`,`id_listino`,`id_iva`),
    ADD KEY `indice_articoli` (`id`,`id_articolo`,`prezzo`,`id_listino`,`id_iva`);

-- | 030000025001

-- prezzi
ALTER TABLE `prezzi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000026000

-- prodotti
ALTER TABLE `prodotti`
    ADD PRIMARY KEY (`id`),     
    ADD KEY `id_tipologia` (`id_tipologia`),     
    ADD KEY `id_marchio` (`id_marchio`),     
    ADD KEY `id_produttore` (`id_produttore`),     
    ADD KEY `nome` (`nome`),     
    ADD KEY `codice_produttore` (`codice_produttore`),     
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `se_sitemap` (`se_sitemap`),
    ADD KEY `se_cacheable` (`se_cacheable`),
    ADD KEY `indice` (`id`,`id_tipologia`,`id_marchio`,`id_produttore`,`nome`,`codice_produttore`);

-- | 030000026400

-- prodotti_categorie
ALTER TABLE `prodotti_categorie`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_prodotto`,`id_categoria`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_categoria` (`id_categoria`), 
    ADD KEY `id_ruolo` (`id_ruolo`),
    ADD KEY `ordine` (`ordine`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_prodotto`,`id_categoria`,`id_ruolo`,`ordine`);

-- | 030000026401

-- prodotti_categorie
ALTER TABLE `prodotti_categorie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000027000

-- progetti
ALTER TABLE `progetti`
    ADD PRIMARY KEY (`id`), 
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_pianificazione` (`id_pianificazione`),
    ADD KEY `id_cliente` (`id_cliente`), 
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_ranking` (`id_ranking`),
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_periodo` (`id_periodo`),      
    ADD KEY `nome` (`nome`), 
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `se_sitemap` (`se_sitemap`),
    ADD KEY `se_cacheable` (`se_cacheable`),
    ADD KEY `data_accettazione` (`data_accettazione`),
    ADD KEY `data_apertura` (`data_apertura`),
    ADD KEY `data_chiusura` (`data_chiusura`),
    ADD KEY `data_archiviazione` (`data_archiviazione`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_tipologia`,`id_pianificazione`,`id_cliente`,`id_indirizzo`,`id_ranking` ,`nome`,`data_accettazione`,`data_apertura`,`data_chiusura`,`data_archiviazione`);

-- | 030000027400

-- progetti_categorie
ALTER TABLE `progetti_categorie`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_progetto`,`id_categoria`), 
    ADD KEY `id_progetto` (`id_progetto`), 
    ADD KEY `id_categoria` (`id_categoria`), 
    ADD KEY `ordine` (`ordine`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_progetto`,`id_categoria`,`ordine`);

-- | 030000027401

-- progetti_categorie
ALTER TABLE `progetti_categorie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000028000

-- provincie
ALTER TABLE `provincie`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_regione`,`nome`),
    ADD UNIQUE KEY `unica_sigla` (`sigla`),
    ADD UNIQUE KEY `unica_codice_istat` (`codice_istat`),
    ADD KEY `id_regione` (`id_regione`),
    ADD KEY `nome` (`nome`),
    ADD KEY `codice_istat` (`codice_istat`),
    ADD KEY `indice` (`id`,`id_regione`,`nome`,`sigla`,`codice_istat`);

-- | 030000028001

-- provincie
ALTER TABLE `provincie` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000028600

-- ranking
ALTER TABLE `ranking`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `nome` (`nome`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `se_fornitore` (`se_fornitore`),
    ADD KEY `se_cliente` (`se_cliente`),
    ADD KEY `se_progetti` (`se_progetti`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`nome`,`ordine`,  `se_cliente`, `se_fornitore`,`se_progetti`);

-- | 030000028601

-- ranking
ALTER TABLE `ranking` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000029400

-- redirect
ALTER TABLE `redirect`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_sito`,`sorgente`),
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`codice_stato_http`,`sorgente`,`destinazione`);
    
-- | 030000029401

-- redirect
ALTER TABLE `redirect` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000029800

-- regimi
ALTER TABLE `regimi`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`),
    ADD KEY `indice` (`id`,`nome`,`codice`); 

-- | 030000029801

-- regimi
ALTER TABLE `regimi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000030200

-- regioni
ALTER TABLE `regioni`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`codice_istat`),
    ADD UNIQUE KEY `unica_nome` (`id_stato`,`nome`),
    ADD KEY `id_stato` (`id_stato`),
    ADD KEY `indice` (`id`,`id_stato`,`nome`,`codice_istat`);

-- | 030000030201

-- regioni
ALTER TABLE `regioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000030800

-- reparti
ALTER TABLE `reparti` 
    ADD PRIMARY KEY (`id`), 
    ADD KEY `id_iva` (`id_iva`), 
    ADD KEY `id_settore` (`id_settore`), 
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_iva`,`id_settore`,`nome`);

-- | 030000030801

-- reparti
ALTER TABLE `reparti`MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000031500

-- rinnovi
ALTER TABLE `rinnovi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica_codice` (`codice`),
    ADD UNIQUE KEY `unica_contratto` (`id_contratto`, `id_tipologia_contratto`, `codice`, `data_inizio`, `data_fine`),
    ADD UNIQUE KEY `unica_progetto` (`id_progetto`, `codice`, `data_inizio`, `data_fine`),
    ADD    KEY `id_tipologia` (`id_tipologia`),
    ADD    KEY `id_periodicita` (`id_periodicita`),
    ADD    KEY `id_contratto` (`id_contratto`),
    ADD KEY `id_licenza` (`id_licenza`),
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_tipologia_contratto` (`id_tipologia_contratto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `indice` ( `id_contratto`, `id_tipologia`, `id_licenza`, `id_progetto`, `id_categoria_progetti`, `data_inizio`, `data_fine`, `codice`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`);

-- | 030000031501

-- rinnovi
ALTER TABLE `rinnovi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000032000

-- risorse
ALTER TABLE `risorse`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `id_testata` (`id_testata`),
    ADD KEY `id_articolo` (`id_articolo`), 
    ADD KEY `id_prodotto` (`id_prodotto`), 
    ADD KEY `id_sito` (`id_sito`),
    ADD KEY `se_sitemap` (`se_sitemap`),
    ADD KEY `se_cacheable` (`se_cacheable`),
    ADD KEY `giorno_pubblicazione` (`giorno_pubblicazione`),
    ADD KEY `mese_pubblicazione` (`mese_pubblicazione`),
    ADD KEY `anno_pubblicazione` (`anno_pubblicazione`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_tipologia`,`codice`,`nome`,`id_testata`,`giorno_pubblicazione`,`mese_pubblicazione`,`anno_pubblicazione`);

-- | 030000032001

-- risorse
ALTER TABLE `risorse` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000034000

-- ruoli_anagrafica
ALTER TABLE `ruoli_anagrafica`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_genitore` (`id_genitore`), 
    ADD KEY `se_didattica` (`se_didattica`),
    ADD KEY `se_produzione` (`se_produzione`),
    ADD KEY `se_organizzazioni` (`se_organizzazioni`), 
    ADD KEY `se_risorse` (`se_risorse`), 
    ADD KEY `se_progetti` (`se_progetti`), 
    ADD KEY `se_immobili` (`se_immobili`),
    ADD KEY `se_contratti` (`se_contratti`),
    ADD KEY `indice` (`id`,`id_genitore`,`nome`,`se_organizzazioni`,`se_risorse`,`se_progetti`, `se_immobili`, `se_contratti`);

-- | 030000034001

-- ruoli_anagrafica
ALTER TABLE `ruoli_anagrafica` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000034400

-- ruoli_file
ALTER TABLE `ruoli_file`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
	ADD KEY `id_genitore` (`id_genitore`), 
	ADD KEY `se_anagrafica` (`se_anagrafica`), 
	ADD KEY `se_pagine` (`se_pagine`), 
	ADD KEY `se_template` (`se_template`), 
	ADD KEY `se_prodotti` (`se_prodotti`), 
	ADD KEY `se_articoli` (`se_articoli`), 
	ADD KEY `se_categorie_prodotti` (`se_categorie_prodotti`), 
	ADD KEY `se_notizie` (`se_notizie`), 
	ADD KEY `se_categorie_notizie` (`se_categorie_notizie`), 
	ADD KEY `se_risorse` (`se_risorse`), 
	ADD KEY `se_categorie_risorse` (`se_categorie_risorse`), 
	ADD KEY `se_mail` (`se_mail`), 
	ADD KEY `se_immobili` (`se_immobili`),
	ADD KEY `se_documenti` (`se_documenti`),
	ADD KEY `indice` (`id`,`id_genitore`,`nome`,`html_entity`,`font_awesome`,`se_anagrafica`,`se_pagine`,`se_template`,`se_prodotti`,`se_articoli`,`se_categorie_prodotti`,`se_notizie`,`se_categorie_notizie`,`se_risorse`,`se_categorie_risorse`);

-- | 030000034401

-- ruoli_file
ALTER TABLE `ruoli_file` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000034850

-- ruoli_mail
ALTER TABLE `ruoli_mail`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `indice` (`id`,`id_genitore`,`nome`);

-- | 030000034851

-- ruoli_mail
ALTER TABLE `ruoli_mail` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000035000

-- ruoli_prodotti
ALTER TABLE `ruoli_prodotti`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_genitore` (`id_genitore`), 
    ADD KEY `indice` (`id`,`id_genitore`,`nome`);

-- | 030000035001

-- ruoli_prodotti
ALTER TABLE `ruoli_prodotti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000037000

-- settori
ALTER TABLE `settori`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`ateco`), 
    ADD KEY `id_genitore` (`id_genitore`), 
    ADD KEY `nome` (`nome`), 
    ADD KEY `ateco` (`ateco`), 
    ADD KEY `indice` (`id`,`id_genitore`,`nome`,`soprannome`,`ateco`);

-- | 030000037001

-- settori
ALTER TABLE `settori` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000042000

-- stati
ALTER TABLE `stati`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`codice_istat`),
    ADD UNIQUE KEY `unica_iso31661alpha2` (`iso31661alpha2`),
    ADD UNIQUE KEY `unica_iso31661alpha3` (`iso31661alpha3`),
    ADD KEY `id_continente` (`id_continente`),
    ADD KEY `indice` (`id`,`id_continente`,`nome`,`iso31661alpha2`,`iso31661alpha3`,`codice_istat`);

-- | 030000042001

-- stati
ALTER TABLE `stati` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000042500

-- step
ALTER TABLE `step`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_funnel`,`nome`),
    ADD KEY `id_funnel` (`id_funnel`),
    ADD KEY `nome` (`nome`),
    ADD KEY `indice` (`id`,`id_funnel`,`ordine`,`nome`);

-- | 030000042201

-- step
ALTER TABLE `step` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000043600

-- telefoni
ALTER TABLE `telefoni`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_anagrafica`,`numero`),
    ADD KEY `id_anagrafica` (`id_anagrafica`),
    ADD KEY `id_tipologia` (`id_tipologia`),
    ADD KEY `numero` (`numero`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id_anagrafica`,`id_tipologia`,`numero`,`se_notifiche`);

-- | 030000043601

-- telefoni
ALTER TABLE `telefoni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000044000

-- template
ALTER TABLE `template`
	ADD PRIMARY KEY (`id`),
  	ADD UNIQUE KEY `unica` (`ruolo`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
  	ADD KEY `indice` (`ruolo`,`nome`,`tipo`,`latenza_invio`, `se_mail`,`se_sms`);

-- | 030000044001

-- template
ALTER TABLE `template` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000050000

-- tipologie_anagrafica
ALTER TABLE `tipologie_anagrafica`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `se_persona_fisica` (`se_persona_fisica`),
    ADD KEY `se_persona_giuridica` (`se_persona_giuridica`),
    ADD KEY `se_pubblica_amministrazione` (`se_pubblica_amministrazione`),
    ADD KEY `se_ecommerce` (`se_ecommerce`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`,`se_persona_fisica`, `se_persona_giuridica`,`se_pubblica_amministrazione`);

-- | 030000050001

-- tipologie_anagrafica
ALTER TABLE `tipologie_anagrafica` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000050400

-- tipologie_attivita
ALTER TABLE `tipologie_attivita`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD UNIQUE KEY `codice` (`codice`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `se_anagrafica` (`se_anagrafica`),
    ADD KEY `se_agenda` (`se_agenda`),
    ADD KEY `se_sistema` (`se_sistema`),
    ADD KEY `se_stampa` (`se_stampa`),
    ADD KEY `se_corsi` (`se_corsi`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`,`se_anagrafica`,`se_agenda`,`se_sistema`);

-- | 030000050401

-- tipologie_attivita
ALTER TABLE `tipologie_attivita` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000050450

-- tipologie_badge
ALTER TABLE `tipologie_badge`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000050451

-- tipologie_badge
ALTER TABLE `tipologie_badge` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000050800

-- tipologie_contatti
ALTER TABLE `tipologie_contatti`
	ADD PRIMARY KEY (`id`),
  	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD KEY `id_genitore` (`id_genitore`),
	ADD KEY `ordine` (`ordine`),
	ADD KEY `nome` (`nome`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
  	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000050801

-- tipologie_contatti
ALTER TABLE `tipologie_contatti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000050900

-- tipologie_contratti
ALTER TABLE `tipologie_contratti` 
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
      ADD KEY `ordine` (`ordine`),
      ADD KEY `nome` (`nome`),
    ADD KEY `id_prodotto` (`id_prodotto`),
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
      ADD KEY `se_tesseramento`(`se_tesseramento`),
      ADD KEY `se_abbonamento`(`se_abbonamento`),
      ADD KEY `se_iscrizione`(`se_iscrizione`),
      ADD KEY `se_immobili`(`se_immobili`),
      ADD KEY `se_acquisto`(`se_acquisto`),
      ADD KEY `se_locazione`(`se_locazione`),
    ADD KEY `se_libero` (`se_libero`),
      ADD KEY `se_prenotazione`(`se_prenotazione`),
      ADD KEY `se_scalare`(`se_scalare`),
    ADD KEY `se_affiliazione`(`se_affiliazione`),
    ADD KEY `se_online`(`se_online`),
      ADD KEY `id_account_inserimento` (`id_account_inserimento`),
      ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`, `ordine`, `nome`, `html_entity`, `font_awesome`, `se_iscrizione`, `se_tesseramento`, `se_abbonamento`, `se_immobili`, `se_acquisto`, `se_locazione`, `se_affiliazione`);

-- | 030000050901

-- tipologie_contratti
ALTER TABLE `tipologie_contratti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000052600

-- tipologie_documenti
ALTER TABLE `tipologie_documenti`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `sigla` (`sigla`),
    ADD KEY `numerazione`(`numerazione`),
    ADD KEY `se_fattura` (`se_fattura`),
    ADD KEY `se_nota_credito` (`se_nota_credito`),
    ADD KEY `se_nota_debito` (`se_nota_debito`),
    ADD KEY `se_trasporto` (`se_trasporto`),
    ADD KEY `se_pro_forma` (`se_pro_forma`),
    ADD KEY `se_offerta` (`se_offerta`),
    ADD KEY `se_ordine` (`se_ordine`),
    ADD KEY `se_ricevuta` (`se_ricevuta`),
    ADD KEY `se_ecommerce` (`se_ecommerce`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`,`se_fattura`,`se_nota_credito`,`se_nota_debito`,`se_trasporto`,`se_pro_forma`,`se_offerta`,`se_ordine`,`se_ricevuta`);

-- | 030000052601

-- tipologie_documenti
ALTER TABLE `tipologie_documenti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000052800

-- tipologie_edifici
ALTER TABLE `tipologie_edifici`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
      ADD KEY `id_account_inserimento` (`id_account_inserimento`),
      ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000052801

-- tipologie_edifici
ALTER TABLE `tipologie_edifici` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000052900

-- tipologie_immobili
ALTER TABLE `tipologie_immobili`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY  `se_residenziale` (`se_residenziale`),
      ADD KEY `se_industriale` (`se_industriale`),
      ADD KEY `id_account_inserimento` (`id_account_inserimento`),
      ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`, `se_residenziale`, `se_industriale`);

-- | 030000052901

-- tipologie_immobili
ALTER TABLE `tipologie_immobili` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000053000

-- tipologie_indirizzi
ALTER TABLE `tipologie_indirizzi`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000053001

-- tipologie_indirizzi
ALTER TABLE `tipologie_indirizzi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000053200

-- tipologie_licenze
ALTER TABLE `tipologie_licenze`
	ADD PRIMARY KEY (`id`),
  	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD KEY `id_genitore` (`id_genitore`),
	ADD KEY `ordine` (`ordine`),
	ADD KEY `nome` (`nome`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
  	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000053201

-- tipologie_licenze
ALTER TABLE `tipologie_licenze` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000053300

-- tipologie_luoghi
ALTER TABLE `tipologie_luoghi`
	ADD PRIMARY KEY (`id`),
  	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD KEY `id_genitore` (`id_genitore`),
	ADD KEY `ordine` (`ordine`),
	ADD KEY `nome` (`nome`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
  	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000053301

-- tipologie_luoghi
ALTER TABLE `tipologie_luoghi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000053400

-- tipologie_mastri
ALTER TABLE `tipologie_mastri`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000053401

-- tipologie_mastri
ALTER TABLE `tipologie_mastri` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000054000

-- tipologie_pagamenti
ALTER TABLE `tipologie_pagamenti`
	ADD PRIMARY KEY (`id`),
  	ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
	ADD KEY `id_genitore` (`id_genitore`),
	ADD KEY `ordine` (`ordine`),
	ADD KEY `nome` (`nome`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
  	ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`font_awesome`);

-- | 030000054001

-- tipologie_pagamenti
ALTER TABLE `tipologie_pagamenti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000054600

-- tipologie_prodotti
ALTER TABLE `tipologie_prodotti`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`se_colori`,`se_taglie`,`se_dimensioni`,`se_imballo`,`se_spedizione`,`se_trasporto`,`se_prodotto`,`se_servizio`);

-- | 030000054601

-- tipologie_prodotti
ALTER TABLE `tipologie_prodotti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000055000

-- tipologie_progetti
ALTER TABLE `tipologie_progetti`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `se_contratto` (`se_contratto`),
      ADD KEY `se_pacchetto` (`se_pacchetto`),
    ADD KEY `se_progetto` (`se_progetto`),
    ADD KEY `se_consuntivo` (`se_consuntivo`),
    ADD KEY `se_forfait` (`se_forfait`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000055001

-- tipologie_progetti
ALTER TABLE `tipologie_progetti` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000055700

-- tipologie_rinnovi
ALTER TABLE `tipologie_rinnovi`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `se_tesseramenti` (`se_tesseramenti`),
      ADD KEY `se_iscrizioni` (`se_iscrizioni`),
      ADD KEY `se_abbonamenti` (`se_abbonamenti`),
      ADD KEY `se_licenze` (`se_licenze`),
      ADD KEY `se_contratti` (`se_contratti`),
      ADD KEY `se_progetti`(`se_progetti`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`, `se_tesseramenti`,`se_iscrizioni`, `se_abbonamenti`, `se_licenze`, `se_contratti`, `se_progetti`);

-- | 030000055701

-- tipologie_rinnovi
ALTER TABLE `tipologie_rinnovi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000056200

-- tipologie_telefoni
ALTER TABLE `tipologie_telefoni`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000056201

-- tipologie_telefoni
ALTER TABLE `tipologie_telefoni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000056600

-- tipologie_todo
ALTER TABLE `tipologie_todo`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `se_agenda` (`se_agenda`),
    ADD KEY `se_ticket` (`se_ticket`),
    ADD KEY `se_commerciale` (`se_commerciale`),
    ADD KEY `se_produzione` (`se_produzione`),
    ADD KEY `se_amministrazione` (`se_amministrazione`),
    ADD KEY `se_corsi` (`se_corsi`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`,`se_agenda`,`se_ticket`,`se_commerciale`,`se_produzione`,`se_amministrazione`);

-- | 030000056601

-- tipologie_todo
ALTER TABLE `tipologie_todo` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000056800

-- tipologie_url
ALTER TABLE `tipologie_url`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000056801

-- tipologie_url
ALTER TABLE `tipologie_url` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000056900

-- tipologie_zone
ALTER TABLE `tipologie_zone`
    ADD PRIMARY KEY (`id`),
      ADD UNIQUE KEY `unica` (`id_genitore`,`nome`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `ordine` (`ordine`),
    ADD KEY `nome` (`nome`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`),
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
      ADD KEY `indice` (`id`,`id_genitore`,`ordine`,`nome`,`html_entity`);

-- | 030000056901

-- tipologie_zone
ALTER TABLE `tipologie_zone` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000060000

-- todo
ALTER TABLE `todo`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`codice`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `id_cliente` (`id_cliente`), 
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_luogo` (`id_luogo`), 
    ADD KEY `id_contatto` (`id_contatto`), 
    ADD KEY `id_progetto` (`id_progetto`), 
    ADD KEY `id_pianificazione` (`id_pianificazione`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_indirizzo`,`id_luogo`,`data_scadenza`,`ora_scadenza`,`data_programmazione`,`ora_inizio_programmazione`,`ora_fine_programmazione`,`anno_programmazione`,`settimana_programmazione`,`data_chiusura`,`id_contatto`,`id_progetto`),
    ADD KEY `indice_pianificazione` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_indirizzo`,`id_luogo`,`data_programmazione`,`ora_inizio_programmazione`,`ora_fine_programmazione`,`anno_programmazione`,`settimana_programmazione`,`id_contatto`,`id_progetto`,`id_pianificazione`),
    ADD KEY `indice_archiviazione` (`id`,`id_tipologia`,`id_anagrafica`,`id_cliente`,`id_indirizzo`,`id_luogo`,`data_programmazione`,`ora_inizio_programmazione`,`ora_fine_programmazione`,`anno_programmazione`,`settimana_programmazione`,`id_contatto`,`id_progetto`,`id_pianificazione`,`data_archiviazione`); 

-- | 030000060001

-- todo
ALTER TABLE `todo` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000062000

-- udm
ALTER TABLE `udm`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`id_base`,`sigla`),
    ADD KEY `id_base` (`id_base`),
    ADD KEY `se_volume`(`se_volume`),
    ADD KEY `se_peso`(`se_peso`),
    ADD KEY `se_tempo`(`se_tempo`),
    ADD KEY `se_lunghezza`(`se_lunghezza`),
    ADD KEY `se_quantita`(`se_quantita`),
     ADD KEY `se_area` (`se_area`),
    ADD KEY `indice` (`id`,`id_base`,`conversione`,`nome`,`sigla`,`se_tempo`,`se_lunghezza`,`se_volume`,`se_quantita`);

-- | 030000062001

-- udm
ALTER TABLE `udm` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000062600

-- url
ALTER TABLE `url`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_tipologia`,`id_anagrafica`,`url`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_anagrafica` (`id_anagrafica`), 
    ADD KEY `url` (`url`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
    ADD KEY `indice` (`id`,`id_tipologia`,`id_anagrafica`,`url`); 

-- | 030000062601

-- url
ALTER TABLE `url` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000062900

-- valutazioni
ALTER TABLE `valutazioni`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_anagrafica`,`id_immobile`,`timestamp_valutazione`),
	ADD KEY `id_anagrafica` (`id_anagrafica`), 
	ADD KEY `id_matricola` (`id_matricola`), 
	ADD KEY `id_immobile` (`id_immobile`), 
	ADD KEY `id_condizione` (`id_condizione`), 
	ADD KEY `id_disponibilita` (`id_disponibilita`), 
	ADD KEY `id_classe_energetica` (`id_classe_energetica`), 
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_matricola`,`id_anagrafica`,`id_immobile`, `id_condizione`, `id_disponibilita`, `id_classe_energetica`); 

-- | 030000062901

-- valutazioni
ALTER TABLE `valutazioni` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000063000

-- valute
ALTER TABLE `valute`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`iso4217`),
    ADD KEY `indice` (`id`,`iso4217`,`html_entity`,`utf8`);

-- | 030000063001

-- valute
ALTER TABLE `valute` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000065000

-- video
ALTER TABLE `video`
     ADD PRIMARY KEY (`id`), 
     ADD UNIQUE KEY `unica_anagrafica` (`id_anagrafica`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_pagina` (`id_pagina`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_file` (`id_file`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_prodotto` (`id_prodotto`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_articolo` (`id_articolo`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_categoria_prodotti` (`id_categoria_prodotti`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_risorse` (`id_risorsa`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_categoria_risorse` (`id_categoria_risorse`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_notizie` (`id_notizia`,`id_ruolo`,`id_lingua`,`path`), 
     ADD UNIQUE KEY `unica_categoria_notizie` (`id_categoria_notizie`,`id_ruolo`,`id_lingua`,`path`), 
     ADD KEY `id_anagrafica` (`id_anagrafica`), 
     ADD KEY `id_pagina` (`id_pagina`), 
     ADD KEY `id_file` (`id_file`), 
     ADD KEY `id_prodotto` (`id_prodotto`), 
     ADD KEY `id_articolo` (`id_articolo`), 
     ADD KEY `id_categoria_prodotti` (`id_categoria_prodotti`), 
     ADD KEY `id_risorsa` (`id_risorsa`), 
     ADD KEY `id_categoria_risorse` (`id_categoria_risorse`), 
     ADD KEY `id_notizia` (`id_notizia`), 
     ADD KEY `id_categoria_notizie` (`id_categoria_notizie`), 
     ADD KEY `id_lingua` (`id_lingua`), 
     ADD KEY `id_ruolo` (`id_ruolo`), 
    ADD KEY `id_progetto` (`id_progetto`),
    ADD KEY `id_categoria_progetti` (`id_categoria_progetti`),
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_edificio` (`id_edificio`), 
    ADD KEY `id_immobile` (`id_immobile`),
    ADD KEY `id_valutazione` (`id_valutazione`), 
     ADD KEY `id_embed` (`id_embed`), 
     ADD KEY `path` (`path`), 
     ADD KEY `id_account_inserimento` (`id_account_inserimento`),
     ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `indice` (`id`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_anagrafica` (`id`,`id_anagrafica`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_pagine` (`id`,`id_pagina`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_file` (`id`,`id_file`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_prodotti` (`id`,`id_prodotto`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_articoli` (`id`,`id_articolo`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_categorie_prodotti` (`id`,`id_categoria_prodotti`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_risorse` (`id`,`id_risorsa`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_categorie_risorse` (`id`,`id_categoria_risorse`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_notizie` (`id`,`id_notizia`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`),
    ADD KEY `indice_categorie_notizie` (`id`,`id_categoria_notizie`,`id_lingua`,`id_ruolo`,`path`,`id_embed`,`codice_embed`,`embed_custom`,`target`,`orientamento`,`ratio`,`nome`,`ordine`);

-- | 030000065001

-- video
ALTER TABLE `video` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000100000

-- zone
ALTER TABLE `zone`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `unica` (`nome`, `id_genitore`),
    ADD KEY `id_tipologia` (`id_tipologia`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `id_genitore` (`id_genitore`),
    ADD KEY `indice` (`id`,`id_genitore`,`nome`, `id_tipologia`);
    
-- | 030000100001

-- zone
ALTER TABLE `zone` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000100200

-- zone_indirizzi
ALTER TABLE `zone_indirizzi`
    ADD PRIMARY KEY (`id`), 
    ADD UNIQUE KEY `unica` (`id_zona`,`id_indirizzo`), 
    ADD KEY `id_indirizzo` (`id_indirizzo`), 
    ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
    ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
    ADD KEY `ordine` (`ordine`),    
    ADD KEY `indice` (`id`,`ordine`, `id_zona`,`id_indirizzo`);

-- | 030000100201

-- zone_indirizzi
ALTER TABLE `zone_indirizzi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | FINE FILE
