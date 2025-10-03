--
-- VISTE
-- =====
-- questo file contiene le query per la creazione delle viste
-- 
-- TODO documentare
--

-- | 090000000101

-- account_view
CREATE OR REPLACE VIEW account_view AS                        --
	SELECT                                                    --
		account.id,                                           --
		account.id_anagrafica,                                --
		coalesce(                                             --
            anagrafica.denominazione,                         --
            concat(                                           --
                anagrafica.cognome, ' ', anagrafica.nome      --
            ), NULL                                           --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
		account.id_mail,                                      --
		mail.indirizzo AS mail,                               -- indirizzo email
		account.id_affiliazione,                              --
		contratti.codice_affiliazione,                        -- codice affiliazione
		account.username,                                     --
		account.password,                                     --
		account.se_attivo,                                    --
		account.token,                                        --
		account.timestamp_login,                              --
		account.timestamp_cambio_password,                    --
		group_concat(                                         --
            gruppi.nome ORDER BY gruppi.id SEPARATOR '|'      --
        ) AS gruppi,                                          -- nomi dei gruppi separati da |
		concat(                                               --
            '|', group_concat(                                --
                gruppi.id ORDER BY gruppi.id SEPARATOR '|'    --
            ), '|'                                            --
        ) AS id_gruppi,                                       -- id dei gruppi separati da | e racchiusi tra |
		group_concat(                                         --
			DISTINCT                                          --
			concat(                                           --
                aga.entita,                                   --
                '#',                                          --
                aga.id_gruppo                                 --
            )                                                 --
			ORDER BY                                          --
                aga.entita,                                   --
                aga.id_gruppo                                 --
			SEPARATOR '|'                                     --
        ) AS id_gruppi_attribuzione,                          -- entita#id_gruppo separati da |
		account.id_account_inserimento,                       --
		account.id_account_aggiornamento,                     --
		account.username AS __label__                         -- etichetta per le tendine e le liste
	FROM account                                              --
		LEFT JOIN anagrafica                                  --
            ON anagrafica.id = account.id_anagrafica          --
		LEFT JOIN mail                                        --
            ON mail.id = account.id_mail                      --
		LEFT JOIN contratti                                   --
            ON contratti.id = account.id_affiliazione         --
		LEFT JOIN account_gruppi                              --
            ON account_gruppi.id_account = account.id         --
		LEFT JOIN account_gruppi_attribuzione AS aga          --
            ON aga.id_account = account.id                    --
		LEFT JOIN gruppi                                      --
            ON gruppi.id = account_gruppi.id_gruppo           --
	GROUP BY account.id                                       --
;                                                             --

-- | 090000000200

-- account_gruppi_view
CREATE OR REPLACE VIEW account_gruppi_view AS                 --
	SELECT                                                    --
		account_gruppi.id,                                    --
		account_gruppi.id_account,                            --
		account.username AS account,                          -- username dell'account
		account_gruppi.id_gruppo,                             --
		gruppi.nome AS gruppo,                                -- nome del gruppo
		account_gruppi.ordine,                                --
		account_gruppi.se_amministratore,                     --
		account_gruppi.id_account_inserimento,                --
		account_gruppi.id_account_aggiornamento,              --
		concat(                                               --
			account.username,                                 --
			' / ',                                            --
			gruppi.nome                                       --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM account_gruppi                                       --
		LEFT JOIN account                                     --
            ON account.id = account_gruppi.id_account         --
		LEFT JOIN gruppi                                      --
            ON gruppi.id = account_gruppi.id_gruppo           --
;                                                             --

-- | 090000000501

-- anagrafica_categorie_view
CREATE OR REPLACE VIEW anagrafica_categorie_view AS           --
	SELECT                                                    --
		anagrafica_categorie.id,                              --
		anagrafica_categorie.id_anagrafica,                   --
		anagrafica_categorie.id_categoria,                    --
		anagrafica_categorie.id_account_inserimento,          --
		anagrafica_categorie.id_account_aggiornamento,        --
		concat(                                               --
			coalesce(                                         --
                a1.denominazione,                             --
                concat( a1.cognome, ' ', a1.nome ),           --
                ''                                            --
            ),                                                --
			' / ',                                            --
			categorie_anagrafica_path(                        --
                anagrafica_categorie.id_categoria             --
            )                                                 --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM anagrafica_categorie                                 --
		LEFT JOIN anagrafica AS a1                            --
            ON a1.id = anagrafica_categorie.id_anagrafica     --
;                                                             --

-- | 090000000900

-- anagrafica_indirizzi_view
CREATE OR REPLACE VIEW anagrafica_indirizzi_view AS           --
	SELECT                                                    --
		anagrafica_indirizzi.id,                              --
		anagrafica_indirizzi.id_anagrafica,                   --
		coalesce(                                             --
            a1.denominazione,                                 --
            concat(                                           --
                a1.cognome, ' ', a1.nome                      --
            ),                                                --
            ''                                                --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
        a1.codice AS codice_anagrafica,                       -- codice dell'anagrafica
		anagrafica_indirizzi.id_indirizzo,                    --
		anagrafica_indirizzi.id_ruolo,                        --
		ri1.nome AS ruolo,                                    -- nome del ruolo dell'indirizzo
        anagrafica_indirizzi.interno,                         --
        anagrafica_indirizzi.indirizzo,                       --
        anagrafica_indirizzi.civico,                          --
        anagrafica_indirizzi.id_comune,                       --
        comuni.nome AS comune,                                -- nome del comune
        comuni.id_provincia AS id_provincia,                  -- chiave esterna per la provincia
        provincie.sigla AS sigla_provincia,                   -- sigla della provincia
        provincie.nome AS provincia,                          -- nome della provincia
        provincie.codice_istat AS codice_istat_provincia,     -- codice ISTAT della provincia
        comuni.codice_istat AS codice_istat_comune,           -- codice ISTAT del comune
        anagrafica_indirizzi.localita,                        --
        anagrafica_indirizzi.cap,                             --
        anagrafica_indirizzi.latitudine,                      --
        anagrafica_indirizzi.longitudine,                     --
        anagrafica_indirizzi.timestamp_geolocalizzazione,     --
        from_unixtime(                                        --
            anagrafica_indirizzi.timestamp_geolocalizzazione, --
            '%Y-%m-%d %H:%i'                                  --
        ) AS data_ora_geolocalizzazione,                      -- data e ora dell'ultima geolocalizzazione
		anagrafica_indirizzi.timestamp_elaborazione,          --
        from_unixtime(                                        --
            anagrafica_indirizzi.timestamp_elaborazione,      --
            '%Y-%m-%d %H:%i'                                  --
        ) AS data_ora_elaborazione,                           -- data e ora dell'ultima elaborazione
		anagrafica_indirizzi.id_account_inserimento,          --
		anagrafica_indirizzi.id_account_aggiornamento,        --
        concat(                                               --
            coalesce(                                         --
                a1.denominazione,                             --
                concat( a1.cognome, ' ', a1.nome ),           --
                ''                                            --
            ),                                                --
            ' - ',                                            --
            concat_ws(                                        --
                ' ',                                          --
                ri1.nome,                                     --
                anagrafica_indirizzi.indirizzo,               --
                anagrafica_indirizzi.civico,                  --
                comuni.nome,                                  --
                provincie.sigla,                              --
                anagrafica_indirizzi.cap                      --
            )                                                 --
        ) AS __label__                                        -- etichetta per le tendine e le liste
    FROM anagrafica_indirizzi                                 --
		INNER JOIN anagrafica AS a1                           --
            ON a1.id = anagrafica_indirizzi.id_anagrafica     --
		LEFT JOIN anagrafica_categorie AS ac1                 --
            ON ac1.id_anagrafica = a1.id                      --
		LEFT JOIN categorie_anagrafica AS ca1                 --
            ON ca1.id = ac1.id_categoria                      --
		LEFT JOIN ruoli_indirizzi AS ri1                      --
            ON ri1.id = anagrafica_indirizzi.id_ruolo         --
		LEFT JOIN tipologie_indirizzi AS ti1                  --
            ON ti1.id = anagrafica_indirizzi.id_tipologia     --
		LEFT JOIN comuni                                      --
            ON comuni.id = anagrafica_indirizzi.id_comune     --
		LEFT JOIN provincie                                   --
            ON provincie.id = comuni.id_provincia             --
    GROUP BY anagrafica_indirizzi.id                          --
;                                                             --

-- | 090000001800

-- attivita_view
CREATE OR REPLACE VIEW `attivita_view` AS                     --
	SELECT	                                                  --
		attivita.id,                                          --
		attivita.id_tipologia,                                --
		tipologie_attivita.nome AS tipologia,                 -- nome della tipologia
		attivita.codice,                                      --
		attivita.id_cliente,                                  --
		a2.codice AS codice_cliente,                          -- codice del cliente
		coalesce(                                             --
            a2.denominazione,                                 --
            concat(                                           --
                a2.cognome, ' ', a2.nome                      --
            ), ''                                             --
        ) AS cliente,                                         -- denominazione o cognome e nome del cliente
		attivita.id_contatto,                                 --
		c1.nome AS contatto,                                  -- nome del contatto
		attivita.id_indirizzo,                                --
		indirizzi.indirizzo AS indirizzo,                     -- indirizzo
		attivita.id_luogo,                                    --
		luoghi_path(                                          --
            coalesce(                                         --
                attivita.id_luogo, todo.id_luogo              --
            )                                                 --
        ) AS luogo,                                           -- percorso del luogo
		attivita.id_messaggio,                                --
		attivita.id_oggetto,                                  --
		concat( asset1.id, ' ', asset1.nome ) AS oggetto,     -- id e nome dell'oggetto
        coalesce(                                             --
            attivita.data_attivita,                           --
            attivita.data_programmazione                      --
        ) AS data_riferimento,                                -- data di riferimento per ordinamento
		coalesce(                                             --
            attivita.ora_inizio,                              --
            attivita.ora_inizio_programmazione,               --
            ''                                                --
        ) AS ora_inizio_riferimento,                          -- ora di inizio di riferimento
		coalesce(                                             --
            attivita.ora_fine,                                --
            attivita.ora_fine_programmazione,                 --
            ''                                                --
        ) AS ora_fine_riferimento,                            -- ora di fine di riferimento
		coalesce(                                             --
            a1.denominazione,                                 --
            concat(                                           --
                a1.cognome, ' ', a1.nome                      --
            ),                                                --
            a3.denominazione,                                 --
            concat(                                           --
                a3.cognome, ' ', a3.nome                      --
            ),                                                --
            ''                                                --
        ) AS anagrafica_riferimento,                          -- denominazione o cognome e nome dell'anagrafica di programmazione o di esecuzione
		attivita.data_scadenza,                               --
		attivita.ora_scadenza,                                --
		attivita.data_programmazione,                         --
		attivita.ora_inizio_programmazione,                   --
		attivita.ora_fine_programmazione,                     --
		attivita.id_anagrafica_programmazione,                --
		coalesce(                                             --
            a3.denominazione,                                 --
            concat(                                           --
                a3.cognome, ' ', a3.nome                      --
            ),                                                --
            ''                                                --
        ) AS anagrafica_programmazione,                       -- denominazione o cognome e nome dell'anagrafica di programmazione
		attivita.ore_programmazione,                          --
		attivita.se_confermata,                               --
		attivita.data_attivita,                               --
		day( data_attivita ) as giorno_attivita,              -- giorno di attivita
		month( data_attivita ) as mese_attivita,              -- mese di attivita
		year( data_attivita ) as anno_attivita,               -- anno di attivita
		attivita.ora_inizio,                                  --
		attivita.latitudine_ora_inizio,                       --
		attivita.longitudine_ora_inizio,                      --
		attivita.data_fine,                                   --
		attivita.ora_fine,                                    --
		attivita.latitudine_ora_fine,                         --
		attivita.longitudine_ora_fine,                        --
		attivita.id_anagrafica,                               --
		coalesce(                                             --
            a1.denominazione,                                 --
            concat( a1.cognome, ' ', a1.nome ),               --
            ''                                                --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
		attivita.id_account,                                  --
		attivita.id_asset,                                    --
		concat( asset2.id, ' ', asset2.nome ) AS asset,       -- id e nome dell'asset
		attivita.ore,                                         --
        da.id_articolo,                                       -- id dell'articolo previsto
        da.quantita AS quantita_prevista,                     -- quantità prevista
		attivita.nome,                                        --
		attivita.id_documento,                                --
		concat(                                               --
			td.sigla,                                         --
			' ',                                              --
			documenti.numero,                                 --
			'/',                                              --
			documenti.sezionale,                              --
			' del ',                                          --
			documenti.data                                    --
		) AS documento,                                       -- tipologia, numero, sezionale e data del documento
		attivita.id_corrispondenza,                           --
		concat_ws(                                            --
            ' ',                                              --
            'da',                                             --
            coalesce(                                         --
                a4.denominazione,                             --
                concat( a4.cognome, ' ', a4.nome ),           --
                ''                                            --
            ),                                                --
            concat(                                           --
                '(',                                          --
                organizzazioni_path(                          --
                    cr.id_organizzazione_mittente             --
                ),                                            --   
                ')'                                           --
            ),                                                --
            tipologie_corrispondenza_path(                    --
                cr.id_tipologia                               --
            ),                                                --
            'per',                                            --
            coalesce(                                         --
                cr.destinatario_denominazione,                --
                concat(                                       --
                    cr.destinatario_cognome,                  --
                    ' ',                                      --
                    cr.destinatario_nome                      --
                ),                                            --
                ''                                            --
            )                                                 --
        ) AS corrispondenza,                                  -- descrizione della corrispondenza
		attivita.id_progetto,                                 --
		progetti.nome AS progetto,                            -- nome del progetto
		attivita.id_contratto,                                --
		concat_ws(                                            --
            ' ',                                              --
            tc.nome,                                          --
            c.nome                                            --
        ) AS contratto,                                       -- tipologia e nome del contratto
		group_concat(                                         --
            DISTINCT                                          --
            if(                                               --
                d.id,                                         --
                categorie_progetti_path( d.id ),              --
                null                                          --
            )                                                 --
            SEPARATOR ' | '                                   --
        ) AS discipline,                                      -- elenco delle discipline del progetto separate da |
		attivita.id_matricola,                                --
        attivita.id_immobile,                                 --
        attivita.id_step,                                     --
        step.nome AS step,                                    -- nome dello step
		attivita.id_pianificazione,                           --
		attivita.id_todo,                                     --
		todo.nome AS todo,                                    -- nome del todo
		attivita.id_mastro_provenienza,                       --
		m1.nome AS mastro_provenienza,                        --
		attivita.id_mastro_destinazione,                      --
		m2.nome AS mastro_destinazione,                       --
		attivita.codice_archivium,                            --
		attivita.token,                                       --
		attivita.id_account_inserimento,                      --
		attivita.timestamp_inserimento,                       --
		attivita.id_account_aggiornamento,                    --
		attivita.timestamp_aggiornamento,                     --
		attivita.timestamp_archiviazione,                     --
		concat(                                               --
			attivita.nome,                                    --
			' / ',                                            --
			attivita.ore,                                     --
			' / ',                                            --
			coalesce(                                         --
                a1.denominazione,                             --
                concat(                                       --
                    a1.cognome,                               --
                    ' ',                                      --
                    a1.nome                                   --
                ),                                            --
                ''                                            --
            )                                                 --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM attivita                                             --
		LEFT JOIN tipologie_attivita                          --
            ON tipologie_attivita.id = attivita.id_tipologia  --
		LEFT JOIN anagrafica AS a1                            --
            ON a1.id = attivita.id_anagrafica                 --
		LEFT JOIN anagrafica AS a2                            --
            ON a2.id = attivita.id_cliente                    --
		LEFT JOIN anagrafica AS a3                            --
            ON a3.id = attivita.id_anagrafica_programmazione  --
		LEFT JOIN anagrafica AS a4                            --
            ON a4.id = attivita.id_corrispondenza             --
		LEFT JOIN contatti AS c1                              --
            ON c1.id = attivita.id_contatto                   --
		LEFT JOIN todo                                        --
            ON todo.id = attivita.id_todo                     --
		LEFT JOIN step                                        --
            ON step.id = attivita.id_step                     --
		LEFT JOIN progetti_categorie AS pc                    --
            ON pc.id_progetto = attivita.id_progetto          --
		LEFT JOIN progetti                                    --
            ON progetti.id = coalesce(                        --
                attivita.id_progetto,                         --
                todo.id_progetto                              --
            )                                                 --
		LEFT JOIN categorie_progetti                          --
            ON categorie_progetti.id = pc.id_categoria        --
		LEFT JOIN categorie_progetti AS d                     --
            ON d.id = pc.id_categoria                         --
                AND d.se_disciplina = 1                       --
		LEFT JOIN indirizzi                                   --
            ON indirizzi.id = attivita.id_indirizzo           --
		LEFT JOIN mastri AS m1                                --
            ON m1.id = attivita.id_mastro_provenienza         --
		LEFT JOIN mastri AS m2                                --
            ON m2.id = attivita.id_mastro_destinazione        --
		LEFT JOIN documenti                                   --
            ON documenti.id = attivita.id_documento           --
		LEFT JOIN tipologie_documenti AS td                   --
            ON td.id = documenti.id_tipologia                 --
		LEFT JOIN contratti AS c                              --
            ON c.id = attivita.id_contratto                   --
		LEFT JOIN tipologie_contratti AS tc                   --
            ON tc.id = c.id_tipologia                         --
		LEFT JOIN corrispondenza AS cr                        --
            ON cr.id = attivita.id_corrispondenza             --
		LEFT JOIN organizzazioni AS o                         --
            ON o.id = cr.id_organizzazione_mittente           --
		LEFT JOIN tipologie_corrispondenza AS tc2             --
            ON tc2.id = cr.id_tipologia                       --
		LEFT JOIN asset AS asset1                             --
            ON asset1.id = attivita.id_asset                  --
		LEFT JOIN asset AS asset2                             --
            ON asset2.id = attivita.id_asset                  --
        LEFT JOIN documenti_articoli AS da                    --
            ON da.id = todo.id_documenti_articoli             --
	GROUP BY attivita.id                                      --
;                                                             --

-- | 090000003100

-- categorie_anagrafica_view
CREATE OR REPLACE VIEW categorie_anagrafica_view AS           --
	SELECT                                                    --
		categorie_anagrafica.id,                              --
		categorie_anagrafica.id_genitore,                     --
		categorie_anagrafica.ordine,                          --
		categorie_anagrafica.nome,                            --
		categorie_anagrafica.se_prospect,                     --
		categorie_anagrafica.se_lead,                         --
		categorie_anagrafica.se_cliente,                      --
		categorie_anagrafica.se_fornitore,                    --
		categorie_anagrafica.se_produttore,                   --
		categorie_anagrafica.se_collaboratore,                --
		categorie_anagrafica.se_interno,                      --
		categorie_anagrafica.se_esterno,                      --
		categorie_anagrafica.se_concorrente,                  --
		categorie_anagrafica.se_gestita,                      --
		categorie_anagrafica.se_amministrazione,              --
		categorie_anagrafica.se_produzione,                   --
		categorie_anagrafica.se_commerciale,                  --
		categorie_anagrafica.se_notizie,                      --
		categorie_anagrafica.se_corriere,                     --
		count( c1.id ) AS figli,                              -- conteggio dei figli
		count( ac.id ) AS membri,                             -- conteggio dei membri
		categorie_anagrafica.id_account_inserimento,          --
		categorie_anagrafica.id_account_aggiornamento,        --
	 	categorie_anagrafica_path(                            --
            categorie_anagrafica.id ) AS __label__            -- etichetta per le tendine e le liste
	FROM categorie_anagrafica                                 --
		LEFT JOIN categorie_anagrafica AS c1                  --
            ON c1.id_genitore = categorie_anagrafica.id       --
		LEFT JOIN anagrafica_categorie AS ac                  --
            ON ac.id_categoria = categorie_anagrafica.id      --
	GROUP BY categorie_anagrafica.id                          --
;                                                             --

-- | 090000005300

-- comuni_view
CREATE OR REPLACE VIEW comuni_view AS                         --
	SELECT                                                    --
		comuni.id,                                            --
		comuni.id_provincia,                                  --
		provincie.nome AS provincia,                          --
		provincie.sigla AS sigla_provincia,                   --
		provincie.id_regione,                                 --
		regioni.nome AS regione,                              --
		regioni.id_stato,                                     --
		stati.nome AS stato,                                  --
		comuni.nome,                                          --
		comuni.codice_istat,                                  --
		comuni.codice_catasto,                                --
		concat(                                               --
			comuni.nome, ' ',                                 --
			coalesce(                                         --
                concat( '(', provincie.sigla, ') '),          --
                ' '                                           --
            ),                                                --
			stati.nome                                        --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM comuni                                               --
		INNER JOIN provincie                                  --
            ON provincie.id = comuni.id_provincia             --
		INNER JOIN regioni                                    --
            ON regioni.id = provincie.id_regione              --
		INNER JOIN stati                                      --
            ON stati.id = regioni.id_stato                    --
;                                                             --

-- | 090000006000

-- consensi_view
CREATE OR REPLACE VIEW `consensi_view` AS                     --   
  SELECT                                                      --  
    consensi.id,                                              --
    consensi.nome,                                            --
    consensi.id_account_inserimento,                          --
    consensi.id_account_aggiornamento,                        --    
    consensi.nome AS __label__                                -- etichetta per le tendine e le liste
  FROM consensi                                               --
;                                                             --

-- | 090000006500

-- consensi_moduli
CREATE OR REPLACE VIEW `consensi_moduli_view` AS              --
  SELECT                                                      --
    consensi_moduli.id,                                       --
    consensi_moduli.id_lingua,                                --
    consensi_moduli.id_consenso,                              --
    consensi_moduli.modulo,                                   --
    consensi_moduli.ordine,                                   --
    consensi_moduli.azione,                                   --
    consensi_moduli.nome,                                     --
    consensi_moduli.informativa,                              --
    consensi_moduli.pagina,                                   --
    consensi_moduli.se_richiesto,                             --
    consensi_moduli.id_account_inserimento,                   --
    consensi_moduli.id_account_aggiornamento,                 --
    concat(                                                   --
      'consenso ',                                            --
      consensi_moduli.id_consenso,                            --
      ' per modulo ',                                         --
      consensi_moduli.modulo                                  --
    ) AS __label__                                            -- etichetta per le tendine e le liste
  FROM consensi_moduli                                        --
;                                                             --

-- | 090000016000

-- lingue_view
CREATE OR REPLACE VIEW lingue_view AS                         --
  SELECT                                                      --
    lingue.id,                                                --
    lingue.nome,                                              --
    lingue.iso6391alpha2,                                     --
    lingue.iso6393alpha3,                                     --
    lingue.ietf,                                              --
    lingue.nome AS __label__                                  -- etichetta per le tendine e le liste
  FROM lingue                                                 --
  ;                                                           --

-- | 090000018600

-- mail_view
CREATE OR REPLACE VIEW `mail_view` AS                         --
	SELECT                                                    --
		mail.id,                                              --
		mail.id_anagrafica,                                   --
		coalesce(                                             --
            a1.denominazione,                                 --
            concat( a1.cognome, ' ', a1.nome ), ''            --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
		mail.indirizzo,                                       --
		mail.se_notifiche,                                    --
		mail.se_pec,                                          --
		mail.server,                                          --
		mail.id_account_inserimento,                          --
		mail.id_account_aggiornamento,                        --
		concat(                                               --
			coalesce(                                         --
                a1.denominazione,                             --
                concat( a1.cognome, ' ', a1.nome ), ''        --
            ),                                                --
			' ',                                              --
			mail.indirizzo                                    --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM mail                                                 --
		LEFT JOIN anagrafica AS a1                            --
            ON a1.id = mail.id_anagrafica                     --
;                                                             --

-- | 090000028000

-- provincie_view
CREATE OR REPLACE VIEW provincie_view AS                      --
	SELECT                                                    --
		provincie.id,                                         --
		provincie.id_regione,                                 --
		regioni.nome AS regione,                              --
		regioni.id_stato,                                     --
		stati.nome AS stato,                                  --
		provincie.nome,                                       --
		provincie.sigla,                                      --
		provincie.codice_istat,                               --
		concat_ws(                                            --
			' ',                                              --
			provincie.nome,                                   --
			concat( '(', provincie.sigla, ')' ),              --
			stati.nome                                        --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM provincie                                            --
		INNER JOIN regioni                                    --
            ON regioni.id = provincie.id_regione              --
		INNER JOIN stati                                      --
            ON stati.id = regioni.id_stato                    --
;                                                             --

-- | 090000029000

-- redirect_view
CREATE OR REPLACE VIEW redirect_view AS                       --
  SELECT                                                      --
    redirect.id,                                              --
    redirect.id_sito,                                         --
    redirect.codice_stato_http,                               --
    redirect.sorgente,                                        --
    redirect.destinazione,                                    --
    redirect.id_account_inserimento,                          --
    redirect.id_account_aggiornamento,                        --
    concat_ws(                                                --
      ' ',                                                    --
      redirect.sorgente,                                      --
      redirect.codice_stato_http,                             --
      redirect.destinazione                                   --
    ) AS __label__                                            -- etichetta per le tendine e le liste
  FROM redirect                                               --
;                                                             --

-- | 090000034801

-- ruoli_indirizzi_view
CREATE OR REPLACE VIEW ruoli_indirizzi_view AS				  --
	SELECT													  --
		ruoli_indirizzi.id,					  				  --
		ruoli_indirizzi.id_genitore,			  			  --
		ruoli_indirizzi.nome,							  	  --
    	ruoli_indirizzi.html_entity,				  		  --
    	ruoli_indirizzi.font_awesome,		  		  		  --
    	ruoli_indirizzi.se_sede_legale,	  		  			  --
    	ruoli_indirizzi.se_sede_operativa,	  		  		  --
    	ruoli_indirizzi.se_residenza,	  		  			  --
    	ruoli_indirizzi.se_domicilio,			  		  	  --
	 	ruoli_indirizzi_path(								  --
			ruoli_indirizzi.id ) AS __label__			  	  -- etichetta per le tendine e le liste
	FROM ruoli_indirizzi									  --
;                                                             --

-- | 090000042000

-- stati_view
CREATE OR REPLACE VIEW stati_view AS                          --
    SELECT                                                    --
		stati.id,                                             --
		stati.id_continente,                                  --
		continenti.nome AS continente,                        -- nome del continente
		stati.nome,                                           --
		stati.iso31661alpha2,                                 --
		stati.iso31661alpha3,                                 --
		stati.codice_istat,                                   --
		stati.data_archiviazione,                             --
		concat_ws(                                            --
			' ',                                              --
			continenti.nome,                                  --
			stati.nome                                        --
		) AS __label__                                        -- etichetta per le tendine e le liste
    FROM stati                                                --
    	LEFT JOIN continenti                                  --
            ON continenti.id = stati.id_continente            --
;                                                             --

-- | 090000043601

-- telefoni_view
CREATE OR REPLACE VIEW telefoni_view AS                       --
	SELECT                                                    --
		telefoni.id,                                          --
		telefoni.id_anagrafica,                               --
		coalesce(                                             --
            a1.denominazione,                                 --
            concat(                                           --
                a1.cognome, ' ', a1.nome                      --
            ),                                                --
            ''                                                --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
		telefoni.id_tipologia,                                --
		t1.nome AS tipologia,                                 -- nome della tipologia
		telefoni.numero,                                      --
		telefoni.se_notifiche,                                --
		telefoni.id_account_inserimento,                      --
		telefoni.id_account_aggiornamento,                    --
		concat_ws(                                            --
			' ',                                              --
			coalesce(                                         --
                a1.denominazione,                             --
                concat( a1.cognome, ' ', a1.nome ),           --
                ''                                            --
            ),                                                --
			t1.nome,                                          --
			telefoni.numero                                   --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM telefoni                                             --
		LEFT JOIN anagrafica AS a1                            --
            ON a1.id = telefoni.id_anagrafica                 --
		LEFT JOIN tipologie_telefoni AS t1                    --
            ON t1.id = telefoni.id_tipologia                  --
;                                                             --

-- | 090000050000

-- tipologie_anagrafica_view
CREATE OR REPLACE VIEW `tipologie_anagrafica_view` AS         --
	SELECT                                                    --
		tipologie_anagrafica.id,                              --
		tipologie_anagrafica.id_genitore,                     --
		tipologie_anagrafica.ordine,                          --
		tipologie_anagrafica.nome,                            --
		tipologie_anagrafica.html_entity,                     --
		tipologie_anagrafica.font_awesome,                    --
		tipologie_anagrafica.se_persona_fisica,               --
        tipologie_anagrafica.se_persona_giuridica,            --
        tipologie_anagrafica.se_pubblica_amministrazione,     --
        tipologie_anagrafica.se_ecommerce,                    --
		tipologie_anagrafica.id_account_inserimento,          --
		tipologie_anagrafica.id_account_aggiornamento,        --
		tipologie_anagrafica_path(                            --
            tipologie_anagrafica.id ) AS __label__            -- etichetta per le tendine e le liste
	FROM tipologie_anagrafica                                 --
;                                                             --

-- | 090000050400

-- tipologie_attivita_view
CREATE OR REPLACE VIEW `tipologie_attivita_view` AS           --
	SELECT                                                    --
		tipologie_attivita.id,                                --
		tipologie_attivita.id_genitore,                       --
		tipologie_attivita.ordine,                            --
		tipologie_attivita.codice,                            --
		tipologie_attivita.nome,                              --
		tipologie_attivita.html_entity,                       --
		tipologie_attivita.font_awesome,                      --
		tipologie_attivita.se_anagrafica,                     --
		tipologie_attivita.se_agenda,                         --
		tipologie_attivita.se_sistema,                        --
		tipologie_attivita.se_stampa,                         --
		tipologie_attivita.se_cartellini,                     --
		tipologie_attivita.se_corsi,                          --
		tipologie_attivita.se_accesso,                        --
		tipologie_attivita.id_account_inserimento,            --
		tipologie_attivita.id_account_aggiornamento,          --
		tipologie_attivita_path(                              --
            tipologie_attivita.id ) AS __label__              -- etichetta per le tendine e le liste
	FROM tipologie_attivita                                   --
;                                                             --

-- | 090000053000

-- tipologie_indirizzi_view
CREATE OR REPLACE VIEW `tipologie_indirizzi_view` AS          --
	SELECT                                                    --
		tipologie_indirizzi.id,                               --
		tipologie_indirizzi.id_genitore,                      --
		tipologie_indirizzi.ordine,                           --
		tipologie_indirizzi.nome,                             --
		tipologie_indirizzi.html_entity,                      --
		tipologie_indirizzi.font_awesome,                     --
		tipologie_indirizzi.id_account_inserimento,           --
		tipologie_indirizzi.id_account_aggiornamento,         --
		tipologie_indirizzi_path(                             --
            tipologie_indirizzi.id                            --
        ) AS __label__                                        -- etichetta per le tendine e le liste
	FROM tipologie_indirizzi                                  --
;                                                             --

-- | 090000056200

-- tipologie_telefoni_view
CREATE OR REPLACE VIEW `tipologie_telefoni_view` AS           --
	SELECT                                                    --
		tipologie_telefoni.id,                                --
		tipologie_telefoni.id_genitore,                       --
		tipologie_telefoni.ordine,                            --
		tipologie_telefoni.nome,                              --
		tipologie_telefoni.html_entity,                       --
		tipologie_telefoni.font_awesome,                      --
		tipologie_telefoni.id_account_inserimento,            --
		tipologie_telefoni.id_account_aggiornamento,          --
		tipologie_telefoni_path(                              --
            tipologie_telefoni.id ) AS __label__              -- etichetta per le tendine e le liste
	FROM tipologie_telefoni                                   --
;                                                             --

-- | 090000056800

-- tipologie_url_view
CREATE OR REPLACE VIEW `tipologie_url_view` AS                --
	SELECT                                                    --
		tipologie_url.id,                                     --
		tipologie_url.id_genitore,                            --
		tipologie_url.ordine,                                 --
		tipologie_url.nome,                                   --
		tipologie_url.html_entity,                            --
		tipologie_url.font_awesome,                           --
		tipologie_url.id_account_inserimento,                 --
		tipologie_url.id_account_aggiornamento,               --
		tipologie_url_path( tipologie_url.id ) AS __label__   -- etichetta per le tendine e le liste
	FROM tipologie_url                                        --
;                                                             --

-- | 090000062601

-- url_view
CREATE OR REPLACE VIEW url_view AS                            --
	SELECT                                                    --
		url.id,                                               --
		url.id_tipologia,                                     --
		tipologie_url.nome AS tipologia,                      -- nome della tipologia
		url.id_anagrafica,                                    --
		coalesce(                                             --
            a1.denominazione,                                 --
            concat( a1.cognome, ' ', a1.nome ),               --
            ''                                                --
        ) AS anagrafica,                                      -- denominazione o cognome e nome dell'anagrafica
		url.url,                                              --
		url.nome,                                             --
		url.username,                                         --
		url.password,                                         --
		url.id_account_inserimento,                           --
		url.id_account_aggiornamento,                         --
		concat_ws(                                            --
			' ',                                              --
			url.url,                                          --
			tipologie_url.nome,                               --
			coalesce(                                         --
                a1.denominazione,                             --
                concat( a1.cognome, ' ', a1.nome ),           --
                ''                                            --
            )                                                 --
		) AS __label__                                        -- etichetta per le tendine e le liste
	FROM url                                                  --
		LEFT JOIN anagrafica AS a1                            --
            ON a1.id = url.id_anagrafica                      --
		LEFT JOIN tipologie_url                               --
            ON tipologie_url.id = url.id_tipologia            --
;                                                             --

-- | 090000999000

-- test_view
CREATE OR REPLACE VIEW test_view AS                           --
  SELECT                                                      --
    test.id,                                                  --
    test.codice,                                              --
    test.nome,                                                --
    concat_ws(                                                --
      ' ',                                                    --
      test.codice,                                            --
      test.nome                                               --
    ) AS __label__                                            -- etichetta per le tendine e le liste
  FROM test                                                   --
;                                                             --

-- | FINE FILE
