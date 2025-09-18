--
-- PROCEDURE
-- =========
-- 
-- TODO documentare
-- 

-- | 070000003100

-- categorie_anagrafica_path
DROP FUNCTION IF EXISTS `categorie_anagrafica_path`;

-- | 070000003101

-- categorie_anagrafica_path
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `categorie_anagrafica_path`( `p1` INT( 11 ) ) RETURNS TEXT CHARSET utf8 COLLATE utf8_general_ci
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole ottenere il path

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT categorie_anagrafica_path( <id> ) AS path

		DECLARE path text DEFAULT '';
		DECLARE step char( 255 ) DEFAULT '';
		DECLARE separatore varchar( 8 ) DEFAULT ' > ';

		WHILE ( p1 IS NOT NULL ) DO

			SELECT
				categorie_anagrafica.id_genitore,
				categorie_anagrafica.nome
			FROM categorie_anagrafica
			WHERE categorie_anagrafica.id = p1
			INTO p1, step;

			IF( p1 IS NULL ) THEN
				SET separatore = '';
			END IF;

			SET path = concat( separatore, step, path );

		END WHILE;

		RETURN path;

END;

-- | 070000003110

-- categorie_anagrafica_path_check
DROP FUNCTION IF EXISTS `categorie_anagrafica_path_check`;

-- | 070000003111

-- categorie_anagrafica_path_check
-- verifica: 2021-06-01 18:35 Fabio Mosti
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `categorie_anagrafica_path_check`( `p1` INT( 11 ), `p2` INT( 11 ) ) RETURNS TINYINT( 1 )
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole verificare il path
		-- p2 int( 11 ) -> l'id dell'oggetto da cercare nel path

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT categorie_anagrafica_path_check( <id1>, <id2> ) AS check

		WHILE ( p1 IS NOT NULL ) DO

			IF( p1 = p2 ) THEN
				RETURN 1;
			END IF;

			SELECT
				categorie_anagrafica.id_genitore
			FROM categorie_anagrafica
			WHERE categorie_anagrafica.id = p1
			INTO p1;

		END WHILE;

		RETURN 0;

END;

-- | 070000003120

-- categorie_anagrafica_path_find_ancestor
DROP FUNCTION IF EXISTS `categorie_anagrafica_path_find_ancestor`;

-- | 070000003121

-- categorie_anagrafica_path_find_ancestor
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `categorie_anagrafica_path_find_ancestor`( `p1` INT( 11 ) ) RETURNS INT( 11 )
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole trovare il progenitore

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT categorie_anagrafica_path_find_ancestor( <id1> ) AS check

		DECLARE p2 int( 11 ) DEFAULT NULL;

		WHILE ( p1 IS NOT NULL ) DO

			SELECT
				categorie_anagrafica.id_genitore,
				categorie_anagrafica.id
			FROM categorie_anagrafica
			WHERE categorie_anagrafica.id = p1
			INTO p1, p2;

		END WHILE;

		RETURN p2;

END;

-- | 070000050400

-- tipologie_attivita_path
DROP FUNCTION IF EXISTS `tipologie_attivita_path`;

-- | 070000050401

-- tipologie_attivita_path
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `tipologie_attivita_path`( `p1` INT( 11 ) ) RETURNS TEXT CHARSET utf8 COLLATE utf8_general_ci
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole ottenere il path

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT tipologie_attivita_path( <id> ) AS path

		DECLARE path text DEFAULT '';
		DECLARE step char( 255 ) DEFAULT '';
		DECLARE separatore varchar( 8 ) DEFAULT ' > ';

		WHILE ( p1 IS NOT NULL ) DO

			SELECT
				tipologie_attivita.id_genitore,
				tipologie_attivita.nome
			FROM tipologie_attivita
			WHERE tipologie_attivita.id = p1
			INTO p1, step;

			IF( p1 IS NULL ) THEN
				SET separatore = '';
			END IF;

			SET path = concat( separatore, step, path );

		END WHILE;

		RETURN path;

END;

-- | 070000050410

-- tipologie_attivita_path_check
DROP FUNCTION IF EXISTS `tipologie_attivita_path_check`;

-- | 070000050411

-- tipologie_attivita_path_check
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `tipologie_attivita_path_check`( `p1` INT( 11 ), `p2` INT( 11 ) ) RETURNS TINYINT( 1 )
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole verificare il path
		-- p2 int( 11 ) -> l'id dell'oggetto da cercare nel path

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT tipologie_attivita_path_check( <id1>, <id2> ) AS check

		WHILE ( p1 IS NOT NULL ) DO

			IF( p1 = p2 ) THEN
				RETURN 1;
			END IF;

			SELECT
				tipologie_attivita.id_genitore
			FROM tipologie_attivita
			WHERE tipologie_attivita.id = p1
			INTO p1;

		END WHILE;

		RETURN 0;

END;

-- | 070000050420

-- tipologie_attivita_path_find_ancestor
DROP FUNCTION IF EXISTS `tipologie_attivita_path_find_ancestor`;

-- | 070000050421

-- tipologie_attivita_path_find_ancestor
CREATE
	DEFINER = CURRENT_USER()
	FUNCTION `tipologie_attivita_path_find_ancestor`( `p1` INT( 11 ) ) RETURNS INT( 11 )
	NOT DETERMINISTIC
	READS SQL DATA
	SQL SECURITY DEFINER
	BEGIN

		-- PARAMETRI
		-- p1 int( 11 ) -> l'id dell'oggetto per il quale si vuole trovare il progenitore

		-- DIPENDENZE
		-- nessuna

		-- TEST
		-- SELECT tipologie_attivita_path_find_ancestor( <id1> ) AS check

		DECLARE p2 int( 11 ) DEFAULT NULL;

		WHILE ( p1 IS NOT NULL ) DO

			SELECT
				tipologie_attivita.id_genitore,
				tipologie_attivita.id
			FROM tipologie_attivita
			WHERE tipologie_attivita.id = p1
			INTO p1, p2;

		END WHILE;

		RETURN p2;

END;

-- | FINE FILE
