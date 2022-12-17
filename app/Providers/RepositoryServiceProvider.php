<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        $this->app->bind(\App\Repositories\SlotsRepository::class, \App\Repositories\SlotsRepositoryEloquent::class);
        $this->app->bind(\App\Repositories\OwnersRepository::class, \App\Repositories\OwnersRepositoryEloquent::class);
        $this->app->bind(\App\Repositories\OwnerSlotsRepository::class, \App\Repositories\OwnerSlotsRepositoryEloquent::class);
        $this->app->bind(\App\Repositories\RegisteredOwnersRepository::class, \App\Repositories\RegisteredOwnersRepositoryEloquent::class);
        $this->app->bind(\App\Repositories\ParkingPoolRepository::class, \App\Repositories\ParkingPoolRepositoryEloquent::class);
        //:end-bindings:
    }
}
