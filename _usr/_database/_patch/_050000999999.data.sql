--
-- DATI
-- questo file contiene le query per l'inserimento dei dati standard nelle tabelle
--

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

-- | FINE FILE
