--
-- LIMITI
-- questo file contiene le query per l'inserimento dei limiti nelle tabelle
--

-- | 060000018600

-- mail
ALTER TABLE `mail`
    ADD CONSTRAINT `mail_ibfk_01`                       FOREIGN KEY (`id_ruolo`) REFERENCES `ruoli_mail` (`id`)                                 ON DELETE NO ACTION ON UPDATE CASCADE,
    ADD CONSTRAINT `mail_ibfk_02`                       FOREIGN KEY (`id_anagrafica`) REFERENCES `anagrafica` (`id`)                            ON DELETE SET NULL  ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_98_nofollow`              FOREIGN KEY (`id_account_inserimento`) REFERENCES `account` (`id`)                      ON DELETE SET NULL  ON UPDATE SET NULL,
    ADD CONSTRAINT `mail_ibfk_99_nofollow`              FOREIGN KEY (`id_account_aggiornamento`) REFERENCES `account` (`id`)                    ON DELETE SET NULL  ON UPDATE SET NULL;

-- | FINE FILE
