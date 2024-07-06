<?php

class csvToolsCest
{

    // settaggi pre test
    public function _before(AcceptanceTester $I)
    {
    }

    // csvFile2array() -> deve restituire il contenuto del CSV di test
    public function csvFile2array(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_csv.tools/_csvFile2array.01.php');
        $I->see("'col1' => string 'val1' (length=4)");
        $I->see("'col2' => string 'val2' (length=4)");
        $I->see("'col3' => string 'val3' (length=4)");
    }

}
