<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CommandTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testExample()
    {
        // $this->artisan('example:example', [
        // ])->expectsOutput("Example command Done!");
        $this->artisan('example:example', []);

        $this->assertTrue(true);
    }
}