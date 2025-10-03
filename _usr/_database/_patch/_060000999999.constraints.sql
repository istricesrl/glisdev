--
-- LIMITI
-- questo file contiene le query per l'inserimento dei limiti nelle tabelle
-- 
-- TODO documentare
--

-- | 060000000200

-- account_gruppi
ALTER TABLE `account_gruppi`
    ADD CONSTRAINT `account_gruppi_ibfk_01`                     FOREIGN KEY (`id_account`) REFERENCES `account` (`id`)                                  ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_02_nofollow`            FOREIGN KEY (`id_gruppo`) REFERENCES `gruppi` (`id`)                                    ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_98_nofollow`            FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `account_gruppi_ibfk_99_nofollow`            FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE CASCADE ON UPDATE CASCADE;

-- | 060000000500

-- anagrafica_categorie
ALTER TABLE `anagrafica_categorie`
    ADD CONSTRAINT `anagrafica_categorie_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_02_nofollow`      FOREIGN KEY (`id_categoria`) REFERENCES `categorie_anagrafica` (`id`)                   ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_categorie_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000000900

-- anagrafica_indirizzi
ALTER TABLE `anagrafica_indirizzi`
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_01`               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_02_nofollow`      FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzi` (`id`)                              ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_03_nofollow`      FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_indirizzi` (`id`)                            ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_98_nofollow`      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `anagrafica_indirizzi_ibfk_99_nofollow`      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000018600

-- mail
ALTER TABLE `mail`
    ADD CONSTRAINT `mail_ibfk_01`                               FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_mail` (`id`)                                 ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `mail_ibfk_02`                               FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE SET NULL  ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_98_nofollow`                      FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL  ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_99_nofollow`                      FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL  ON UPDATE SET NULL;

-- | 060000043600

-- telefoni
ALTER TABLE `telefoni`
    ADD CONSTRAINT `telefoni_ibfk_01`                           FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `telefoni_ibfk_02_nofollow`                  FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_telefoni` (`id`)                     ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `telefoni_ibfk_98_nofollow`                  FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `telefoni_ibfk_99_nofollow`                  FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL ON UPDATE SET NULL;

-- | 060000056200

-- tipologie_telefoni
ALTER TABLE `tipologie_telefoni`
    ADD CONSTRAINT `tipologie_telefoni_ibfk_01_nofollow`        FOREIGN KEY (`id_genitore`) REFERENCES `tipologie_telefoni` (`id`)                      ON DELETE NO ACTION ON UPDATE CASCADE;

-- | 060000062600

-- url
ALTER TABLE `url`
    ADD CONSTRAINT `url_ibfk_01_nofollow`                       FOREIGN KEY (`id_tipologia`) REFERENCES `tipologie_url`(`id`)                           ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `url_ibfk_02       `                         FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `url_ibfk_98_nofollow`                       FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL ON UPDATE SET NULL,
    ADD CONSTRAINT `url_ibfk_99_nofollow`                       FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL ON UPDATE SET NULL;

-- | FINE FILE
