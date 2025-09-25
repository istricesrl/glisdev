--
-- DATI
-- ====
-- questo file contiene le query per l'inserimento dei dati standard nelle tabelle
-- 
-- TODO documentare
--

-- | 050000003100

-- categorie_anagrafica
INSERT IGNORE INTO `categorie_anagrafica` (`id`, `id_genitore`, `ordine`, `nome`, `note`, `se_lead`, `se_prospect`, `se_cliente`, `se_fornitore`, `se_produttore`, `se_collaboratore`, `se_interno`, `se_esterno`, `se_concorrente`, `se_gestita`, `se_amministrazione`, `se_produzione`, `se_commerciale`, `se_notizie`, `se_corriere`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
(1,	NULL,	NULL,	'contatti',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	NULL,	NULL,	'collaboratori',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	2,	NULL,	'agenti',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	NULL,	NULL,	'fornitori',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	NULL,	NULL,	'aziende gestite',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	NULL,	NULL,	'rivenditori',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	1,	NULL,	'lead',	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	1,	NULL,	'prospect',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	1,	NULL,	'clienti',	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	NULL,	NULL,	'corrieri',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(11,	2,	NULL,	'istruttori',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

-- | 050000006000

-- consensi
INSERT IGNORE INTO `consensi` (`id`, `nome`, `note`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
('PRIVACY_POLICY',                  'la privacy e cookie policy del sito',      NULL,   NULL,   NULL,   NULL,   NULL),
('EVASIONE_ORDINE',                 "evasione dell\'ordine",                    NULL,   NULL,   NULL,   NULL,   NULL),
('INVIO_COMUNICAZIONI_MARKETING',   'invio di comunicazioni commerciali',       NULL,   NULL,   NULL,   NULL,   NULL);

-- | 050000006500

-- consensi_moduli
INSERT IGNORE INTO `consensi_moduli` (`id`, `id_lingua`, `id_consenso`, `modulo`, `ordine`, `azione`, `nome`, `informativa`, `note`, `pagina`, `se_richiesto`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
(1, 1,    'PRIVACY_POLICY',                 'ecommerce',    10,    'letto_e_accetto',  'la privacy e cookie policy del sito',                                       NULL,                                   NULL,    'privacy', 1,      NULL,   NULL,   NULL,   NULL),
(2, 1,    'EVASIONE_ORDINE',                'ecommerce',    20,    'autorizzo',        "il trattamento dei miei dati per l\'evasione del mio ordine",               "evasione dell\'ordine",                NULL,    '',        1,      NULL,   NULL,   NULL,   NULL),
(3, 1,    'INVIO_COMUNICAZIONI_MARKETING',  'ecommerce',    30,    'autorizzo',        "il trattamento dei miei dati per l\'invio di comunicazioni commerciali",    'invio di comunicazioni commerciali',   NULL,    '',        NULL,   NULL,   NULL,   NULL,   NULL);

-- | 050000007100

-- continenti
INSERT IGNORE INTO `continenti` (`id`, `codice`, `nome`) VALUES
(1,	'EU',	'Europa'),
(2,	'AF',	'Africa'),
(3,	'AS',	'Asia'),
(4,	'NA',	'Nord America'),
(5,	'AU',	'Oceania'),
(6,	'LA',	'America Latina'),
(7,	'AN',	'Antartide');

-- | 050000016000

-- lingue
INSERT IGNORE INTO `lingue` (`id`, `nome`, `note`, `iso6391alpha2`, `iso6393alpha3`, `ietf`) VALUES
(1,     'italiano',     'italiano (Italia)',        'it',    'ita',    'it-IT'),
(2,     'ceco',         'ceco (Repubblica Ceca)',   'cs',    'ces',    'cs-CZ'),
(3,     'inglese',      'inglese (Regno Unito)',    'en',    'eng',    'en-GB'),
(4,     'francese',     'francese (Francia)',       'fr',    'fra',    'fr-FR'),
(5,     'tedesco',      'tedesco (Germania)',       'de',    'deu',    'de-DE'),
(6,     'ungherese',    'ungherese (Ungheria)',     'hu',    'hun',    'hu-HU'),
(7,     'giapponese',   'giapponese (Giappone)',    'ja',    'jpn',    'ja-JP'),
(8,     'polacco',      'polacco (Polonia)',        'pl',    'pol',    'pl-PL'),
(9,     'portoghese',   'portoghese (Portogallo)',  'pt',    'por',    'pt-PT'),
(10,    'russo',        'russo (Russia)',           'ru',    'rus',    'ru-RU'),
(11,    'spagnolo',     'spagnolo (Spagna)',        'es',    'spa',    'es-ES'),
(12,    'svedese',      'svedese (Svezia)',         'sv',    'swe',    'sv-SE'),
(13,    'americano',    'inglese (Stati Uniti)',    'en',    'eng',    'en-US'),
(14,    'croato',       'croato (Croazia)',         'hr',    'hrv',    'hr-HR'),
(15,    'rumeno',       'rumeno (Romania)',         'ro',    'ron',    'ro-RO');

-- | 050000034800

-- ruoli_indirizzi
INSERT IGNORE INTO `ruoli_indirizzi` (`id`, `nome`, `html_entity`, `font_awesome`, `se_sede_legale`, `se_sede_operativa`, `se_residenza`, `se_domicilio`) VALUES
(1,	'sede legale',	    '&#xf1ad;',	    '',     1,	    NULL,	NULL,	NULL),
(2,	'sede operativa',	'&#xf275;',     '',     NULL,	1,	    NULL,	NULL),
(3,	'casa',             '&#xf015;',     '',     NULL,	NULL,	1,	    NULL),
(4,	'residenza',	    '&#xf015;',	    '',     NULL,	NULL,	1,	    NULL),
(5,	'domicilio',	    '&#xf015;',	    '',     NULL,	NULL,	1,	    1);

-- | 050000050000

-- tipologie_anagrafica
INSERT INTO `tipologie_anagrafica` (`id`, `id_genitore`, `ordine`, `nome`, `sigla`, `html_entity`, `font_awesome`, `se_persona_fisica`, `se_persona_giuridica`, `se_pubblica_amministrazione`, `se_ecommerce`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
(1,	NULL,	10,	'persone fisiche',	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	NULL,	20,	'persone giuridiche',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	7,	10,	'signor',	'sig.',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	8,	20,	'signora',	'sig.ra',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	2,	10,	'spettabile',	'spett.',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	NULL,	20,	'pubblica amministrazione',	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	1,	NULL,	'gentilissimo',	'gent.mo',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	1,	NULL,	'gentilissima',	'gent.ma',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	6,	NULL,	'spettabile',	'spett.',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	NULL);

-- | 050000053000

-- tipologie_indirizzi
INSERT IGNORE INTO `tipologie_indirizzi` (`id`, `id_genitore`, `ordine`, `nome`, `html_entity`, `font_awesome`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
(1,	    NULL,	NULL,	'calle',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	    NULL,	NULL,	'campiello',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	    NULL,	NULL,	'campo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	    NULL,	NULL,	'carraia',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	    NULL,	NULL,	'carrarone',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	    NULL,	NULL,	'chiasso',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	    NULL,	NULL,	'circondario',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	    NULL,	NULL,	'circonvallazione',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	    NULL,	NULL,	'contrà',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	NULL,	NULL,	'contrada',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	NULL,	NULL,	'corso',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(12,	NULL,	NULL,	'diga',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(13,	NULL,	NULL,	'discesa',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	NULL,	NULL,	'frazione',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(15,	NULL,	NULL,	'giardino',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(16,	NULL,	NULL,	'largo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(17,	NULL,	NULL,	'località',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(18,	NULL,	NULL,	'lungoargine',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(19,	NULL,	NULL,	'lungolago',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(20,	NULL,	NULL,	'lungomare',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(21,	NULL,	NULL,	'maso',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(22,	NULL,	NULL,	'parallela',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(23,	NULL,	NULL,	'passeggiata',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(24,	NULL,	NULL,	'piazza',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(25,	NULL,	NULL,	'piazzale',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(26,	NULL,	NULL,	'piazzetta',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(27,	NULL,	NULL,	'rotonda',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(28,	NULL,	NULL,	'salita',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(29,	NULL,	NULL,	'strada',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(30,	NULL,	NULL,	'stradella',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(31,	NULL,	NULL,	'stradello',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(32,	NULL,	NULL,	'traversa',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(33,	NULL,	NULL,	'via',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(34,	NULL,	NULL,	'viale',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(35,	NULL,	NULL,	'vico',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(36,	NULL,	NULL,	'vicoletto',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(37,	NULL,	NULL,	'vicolo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(38,	NULL,	NULL,	'vietta',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(39,	NULL,	NULL,	'viottolo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(40,	NULL,	NULL,	'viuzza',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(41,	NULL,	NULL,	'viuzzo',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

-- | 050000056800

-- tipologie_url
INSERT INTO `tipologie_url` (`id`, `id_genitore`, `ordine`, `nome`, `html_entity`, `font_awesome`, `id_account_inserimento`, `timestamp_inserimento`, `id_account_aggiornamento`, `timestamp_aggiornamento`) VALUES
(1,	NULL,	NULL,	'web',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	NULL,	NULL,	'social',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	NULL,	NULL,	'servizi',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	1,	NULL,	'sito',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	1,	NULL,	'portale',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	1,	NULL,	'e-commerce',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	1,	NULL,	'blog',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	1,	NULL,	'landing page',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	2,	NULL,	'LinkedIn',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	2,	NULL,	'Facebook',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	2,	NULL,	'Twitter / X',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(12,	2,	NULL,	'Instagram',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(13,	2,	NULL,	'YouTube',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	2,	NULL,	'TikTok',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(15,	3,	NULL,	'FTP',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

-- | 050000056200

-- tipologie_telefoni
INSERT IGNORE INTO `tipologie_telefoni` (`id`, `id_genitore`, `ordine`, `nome`, `html_entity`, `font_awesome`) VALUES
(1,	NULL,   10,     'telefono',	    '&#xf095;',     ''),
(2,	NULL,   20,     'mobile',	    '&#xf10b;',     ''),
(3,	NULL,   30,     'fax',	        '&#xf02f;',     ''),
(4,	NULL,   40,     'telefono/fax',	'&#xf1ac;',     '');

-- | FINE FILE
