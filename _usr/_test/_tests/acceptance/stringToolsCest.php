<?php

class stringToolsCest 
{

    // settaggi pre test
    public function _before(AcceptanceTester $I)
    {
    }

    // writeByte() -> deve restituire una stringa con la dimensione e relativa unità di misura
    public function writeByte(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_string.tools/_writeBytes.01.php');
        $I->see("string '20,00 Bytes' (length=11)");
        $I->see("string '1,95 Kb' (length=7)");
        $I->see("string '1,91 Mb' (length=7)");
        $I->see("string '1,86 Gb' (length=7)");
        $I->see("string '1,82 Tb' (length=7)");
    }

    // riduciCaratteriDoppi() -> deve restituire una stringa con i caratteri doppi ridotti
    public function riduciCaratteriDoppi(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_string.tools/_riduciCaratteriDoppi.01.php');
        $I->see("string 'stringa di prova 01' (length=19)");
        $I->see("string 'stringa +di prova 02' (length=20)");
        $I->see("string 'stringa di prova 03' (length=19)");
    }

    // empty2null() -> deve restituire null se la stringa è vuota
    public function empty2null(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_string.tools/_empty2null.01.php');
        $I->see("0 => string '123' (length=3)");
        $I->see("1 => string '123' (length=3)");
        $I->see("2 => null");
        $I->see("3 => string '0' (length=1)");
        $I->see("4 => null");
        $I->see("5 => null");
        $I->see("6 => string 'abc' (length=3)");
        $I->see("7 => string 'abc' (length=3)");
    }

    // settaggi post test
    public function _after(AcceptanceTester $I)
    {
    }

}