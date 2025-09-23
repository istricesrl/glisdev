--
-- INDICI
-- questo file contiene le query per la creazione degli indici delle tabelle
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
-- tipologia: tabella gestita
ALTER TABLE `account` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000120

-- account_gruppi
ALTER TABLE `account_gruppi`
	ADD PRIMARY KEY (`id`),
	ADD UNIQUE KEY `unica` (`id_account`,`id_gruppo`),
	ADD KEY `id_account` (`id_account`),
	ADD KEY `id_gruppo` (`id_gruppo`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`id_account`,`id_gruppo`,`ordine`);

-- | 030000000121

-- account_gruppi
ALTER TABLE `account_gruppi` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | 030000000130

-- account_gruppi_attribuzione
ALTER TABLE `account_gruppi_attribuzione`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_account`,`id_gruppo`,`entita`), 
	ADD KEY `id_account` (`id_account`), 
	ADD KEY `id_gruppo` (`id_gruppo`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`), 
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`), 
	ADD KEY `indice` (`id`,`id_account`,`id_gruppo`,`ordine`,`entita`);

-- | 030000000131

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

-- | 030000003100

-- categorie_anagrafica
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

-- | 030000006400

-- consensi
ALTER TABLE `consensi`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `nome` (`nome`), 
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`,`nome`,`id_account_inserimento`,`id_account_aggiornamento`);

-- | 030000006500

-- consensi_moduli
ALTER TABLE `consensi_moduli`
	ADD PRIMARY KEY (`id`), 
	ADD UNIQUE KEY `unica` (`id_consenso`, `id_lingua`, `modulo`), 
	ADD KEY `id_lingua` (`id_lingua`),
	ADD KEY `id_consenso` (`id_consenso`),
	ADD KEY `modulo` (`modulo`),
	ADD KEY `ordine` (`ordine`),
	ADD KEY `azione` (`azione`),
	ADD KEY `nome` (`nome`),
	ADD KEY `informativa` (`informativa`),
	ADD KEY `pagina` (`pagina`),
	ADD KEY `se_richiesto` (`se_richiesto`),
	ADD KEY `id_account_inserimento` (`id_account_inserimento`),
	ADD KEY `id_account_aggiornamento` (`id_account_aggiornamento`),
	ADD KEY `indice` (`id`, `id_consenso`, `id_lingua`, `modulo`,`nome`,`ordine`,`azione`, `informativa`, `pagina`, `se_richiesto` );

-- | 030000006501

-- consensi_moduli
ALTER TABLE `consensi_moduli` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- | FINE FILE
