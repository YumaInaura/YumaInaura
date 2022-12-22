<?php

use PHPUnit\Framework\TestCase;
use App\Arithmetic;

class arithmeticTest extends TestCase{

    protected $obj;
    protected function setUp() :void {
        $this->object = new Arithmetic();
    }

    public function testAdd() {
        $this->assertEquals(5,$this->object->add(2,3));
    }
    public function testSub() {
        $this->assertEquals(5,$this->object->substract(8,3));
    }
    public function testMulti() {
        $this->assertEquals(6,$this->object->multiply(2,3));
    }
    public function testDiv() {
        $this->assertEquals(5,$this->object->divide(10,2));
    }
}
?>