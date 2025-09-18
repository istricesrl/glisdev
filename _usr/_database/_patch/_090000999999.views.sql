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

-- | 090000050401

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
