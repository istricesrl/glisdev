<?php

    /**
     * test del modulo contatti
     *
     * compila il modulo contatti del sito come farebbe un visitatore e verifica che arrivi al server con i campi
     * compilati; la pagina e' quella del sito di esempio di glisdev, un deploy con una pagina contatti diversa
     * sostituisce questo test con mod/CT000.contatti/usr/test/tests/frontend/contattiCest.php
     *
     * il test si ferma al file che il controller scrive in var/spool/contatti/ prima della verifica anti spam,
     * perche' il reCAPTCHA v3 da' punteggio zero al browser headless e la riga in contatti non viene scritta;
     * verifica quindi tutto il percorso lato client ( pagina, JavaScript, token reCAPTCHA, invio ) ma non il
     * salvataggio nel database
     *
     */

    class contattiCest {

        // momento di inizio del test, per riconoscere i file di spool scritti durante il test
        protected $inizio;

        // pulizia prima del test
        public function _before( FrontendTester $I ) {

            $this->inizio = time();
            $I->deleteTestRecords( 'contatti', 'yaml', true );

        }

        // pulizia dopo il test, compresi i file di spool del test
        public function _after( FrontendTester $I ) {

            $I->deleteTestRecords( 'contatti', 'yaml', true );

            foreach( glob( DIR_VAR_SPOOL . 'contatti/*.log' ) as $file ) {
                if( strpos( file_get_contents( $file ), \Helper\Glisweb::RECORD_PREFIX ) !== false ) {
                    unlink( $file );
                }
            }

        }

        // invio del modulo contatti
        public function invio( FrontendTester $I ) {

            $nome = $I->grabTestName( 'contatti' );

            $I->amOnPage( '/contatti.it-IT.html' );
            $I->rifiutaCookie();

            // compilazione e invio
            $I->fillField( '#esempioform input[name="__ct__[default][nome]"]', $nome );
            $I->fillField( '#esempioform input[name="__ct__[default][mail]"]', 'test@example.com' );
            $I->checkOption( '#__ct___default_privacy_PRIVACY_POLICY_checkbox' );
            $I->click( '#esempioform button.g-recaptcha' );

            // il modulo arriva al server, col token reCAPTCHA ottenuto dal JavaScript della pagina
            $I->waitForElement( '#esempioform', 20 );
            $ricevuto = false;
            for( $i = 0; $i < 20 && $ricevuto === false; $i++ ) {
                foreach( glob( DIR_VAR_SPOOL . 'contatti/default.*.log' ) as $file ) {
                    if( filemtime( $file ) >= $this->inizio && strpos( file_get_contents( $file ), $nome ) !== false ) {
                        $ricevuto = file_get_contents( $file );
                    }
                }
                if( $ricevuto === false ) { sleep( 1 ); }
            }

            $I->assertNotFalse( $ricevuto, 'il modulo contatti non e\' arrivato al server' );
            $I->assertStringContainsString( 'test@example.com', $ricevuto );
            $I->assertMatchesRegularExpression( '/\[__recaptcha_token__\] => \S+/', $ricevuto );

        }

    }
