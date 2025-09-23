--
-- VISTE
-- =====
-- questo file contiene le query per la creazione delle viste
--
-- CRITERI DI VERIFICA
-- una definizione di view si può definire verificata se:
-- - riporta esplicitamente tutte e sole le colonne significative (evitare SELECT * FROM)
-- - le colonne appaiono nell'ordine in cui si trovano nella tabella, al netto delle colonne aggiunte dalla view
-- - la view si riferisce a una tabella non deprecata e non contengono colonne deprecate
-- - la view non fa riferimento a tabelle o colonne deprecate
-- - le colonne sono correttamente documentate, in ordine, nel relativo file dox
--

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
