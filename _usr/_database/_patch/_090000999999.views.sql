--
-- VISTE
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

-- | 090000999000

-- redirect_view
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
