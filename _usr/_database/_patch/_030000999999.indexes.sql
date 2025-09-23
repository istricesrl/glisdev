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

-- | FINE FILE
