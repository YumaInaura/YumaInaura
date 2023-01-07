<?php

namespace App\Providers;

use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LoginController;

Route::get('/greeting', function () {
    return 'Hello World';
});

$languages = array("", "en");
foreach ($languages as &$language) {
    Route::get("{$language}/grand/top", 'Grand\TopController@index');
}

Route::get('/foo/{bar}', function ($bar) {
    return 'Hello';
})->where('bar', '(xxx|yyy)');
# /foo/yyy
# /foo/yyy

Route::get('/authcheck_api', function () {
    return 'You have permission';
})->middleware(['auth:sanctum'],'all');

Route::middleware('auth:sanctum')->get('authcheck_browser', function () {
    return "You have permission";
});

Route::post('/tokens/create', [LoginController::class, 'login']);

class RouteServiceProvider extends ServiceProvider
{
    /**
     * The path to the "home" route for your application.
     *
     * Typically, users are redirected here after authentication.
     *
     * @var string
     */
    public const HOME = '/dashboard';

    /**
     * Define your route model bindings, pattern filters, and other route configuration.
     *
     * @return void
     */
    public function boot()
    {
        $this->configureRateLimiting();

        $this->routes(function () {
            Route::middleware('api')
                ->prefix('api')
                ->group(base_path('routes/api.php'));

            Route::middleware('web')
                ->group(base_path('routes/web.php'));
        });
    }

    /**
     * Configure the rate limiters for the application.
     *
     * @return void
     */
    protected function configureRateLimiting()
    {
        RateLimiter::for('api', function (Request $request) {
            return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
        });
    }
}
