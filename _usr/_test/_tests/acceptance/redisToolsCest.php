<?php

class redisToolsCest
{

    // settaggi pre test
    public function _before(AcceptanceTester $I)
    {
    }

    // redisUniqueKey() -> deve restituire un valore con il suffisso univoco del sito
    public function redisUniqueKey(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisUniqueKey.01.php');
        $I->see('GLISDEV_ISTRICESRL_COM_TEST');
    }

    // redisAddKeyAgeSuffix() -> deve restituire un valore con il suffisso '_AGE'
    public function redisAddKeyAgeSuffix(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisAddKeyAgeSuffix.01.php');
        $I->see('TEST_AGE');
    }

    // redisWrite() -> deve restituire OK
    public function redisWrite(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisWrite.01.php');
        $I->see("string 'OK'");
    }

    // redisRead() -> deve restituire il valore scritto con apcuWrite()
    public function redisRead(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisRead.01.php');
        $I->see("string 'OK'");
        $I->see('TEST CONTENT');
    }

    // redisGetKeyAge() -> deve restituire un int
    public function redisGetKeyAge(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisGetKeyAge.01.php');
        $I->see("string 'OK'");
        $I->see('(length=10)');
    }

    // redisDelete() -> deve restituire true
    public function redisDelete(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisDelete.01.php');
        $I->see("string 'OK'");
        $I->see('int 1');
    }

    // redisFlush() -> deve restituire true
    public function redisFlush(AcceptanceTester $I)
    {
        $I->amOnPage('/_usr/_examples/_lib/_redis.tools/_redisFlush.01.php');
        $I->see("string 'OK'");
    }

    // settaggi post test
    public function _after(AcceptanceTester $I)
    {
    }

}
