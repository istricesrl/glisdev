--
-- VISTE STATICHE
-- ==============
-- questo file contiene le query per la creazione delle tabelle per le view statiche
--

-- | 080000000400

-- anagrafica_view_static
CREATE TABLE IF NOT EXISTS `anagrafica_view_static` (         --
  `id` int(11) PRIMARY KEY NOT NULL,                          --
  `tipologia` char(32) DEFAULT NULL,                          --
  `codice` char(32) DEFAULT NULL,                             --
  `riferimento` char(32) DEFAULT NULL,                        --
  `nome` char(64) DEFAULT NULL,                               --
  `cognome` char(255) DEFAULT NULL,                           --
  `denominazione` char(255) DEFAULT NULL,                     --
  `soprannome` char(128) DEFAULT NULL,                        --
  `sesso` char(1) DEFAULT NULL,                               --
  `codice_fiscale` char(32) DEFAULT NULL,                     --
  `partita_iva` char(32) DEFAULT NULL,                        --
  `ranking` char(128) DEFAULT NULL,                           --
  `recapiti` text,                                            --
  `id_stato` int(11) DEFAULT NULL,                            --
  `id_provincia` int(11) DEFAULT NULL,                        --
  `se_prospect` tinyint(1) DEFAULT NULL,                      --
  `se_lead` tinyint(1) DEFAULT NULL,                          --
  `se_cliente` tinyint(1) DEFAULT NULL,                       --
  `se_fornitore` tinyint(1) DEFAULT NULL,                     --
  `se_produttore` tinyint(1) DEFAULT NULL,                    --
  `se_collaboratore` tinyint(1) DEFAULT NULL,                 --
  `se_interno` tinyint(1) DEFAULT NULL,                       --
  `se_esterno` tinyint(1) DEFAULT NULL,                       --
  `se_commerciale` tinyint(1) DEFAULT NULL,                   --
  `se_concorrente` tinyint(1) DEFAULT NULL,                   --
  `se_gestita` tinyint(1) DEFAULT NULL,                       --
  `se_amministrazione` tinyint(1) DEFAULT NULL,               --
  `se_notizie` tinyint(1) DEFAULT NULL,                       --
  `categorie` text,                                           --
  `telefoni` text,                                            --
  `mail` text,                                                --
  `anno_nascita` char(32),                                    --
  `mese_nascita` char(32),                                    --
  `giorno_nascita` char(32),                                  --
  `data_nascita` char(32),                                    --
  `id_comune_nascita` int(11) DEFAULT NULL,                   --
  `data_archiviazione` date DEFAULT NULL,                     --
  `id_account_inserimento` int(11) DEFAULT NULL,              --
  `timestamp_inserimento` int(11) DEFAULT NULL,               --
  `id_account_aggiornamento` int(11) DEFAULT NULL,            --
  `timestamp_aggiornamento` int(11) DEFAULT NULL,             --
  `__label__` text,                                           --
  UNIQUE KEY `codice` (`codice`)                              --
) ENGINE=MyISAM DEFAULT CHARSET=utf8;                         --

-- | FINE FILE
