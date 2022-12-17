<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MainController;
use Inertia\Inertia;

Route::middleware(['auth:sanctum', config('jetstream.auth_session'),'verified',])->group(function () {

    Route::get('/dashboard', [MainController::class, 'showDashboard'])->name('dashboard');
    Route::get('/', [MainController::class, 'showDashboard'])->name('/');

    Route::get('/addParking', [MainController::class, 'addParking'])->name('addParking');
    Route::post('/storeOwnerSlot', [MainController::class, 'storeOwnerSlot'])->name('storeOwnerSlot');
    Route::post('/shareParkingStore', [MainController::class, 'shareParkingStore'])->name('shareParkingStore');
    Route::get('/searchParking', [MainController::class, 'searchParking'])->name('searchParking');
    Route::get('/getSharedSlotsData', [MainController::class, 'getSharedSlotsData'])->name('getSharedSlotsData');
    Route::get('/removeSharedSlot/{slot_id}', [MainController::class, 'removeSharedSlot'])->name('removeSharedSlot');
    Route::get('/viewRequests', [MainController::class, 'viewRequests'])->name('viewRequests');
    Route::get('/updateSlotReserved/{slot_id}', [MainController::class, 'updateSlotReserved'])->name('updateSlotReserved');
    Route::get('/myRequests', [MainController::class, 'myRequests'])->name('myRequests');
    Route::get('/updateApproveRequest/{slot_id}', [MainController::class, 'updateApproveRequest'])->name('updateApproveRequest');
    Route::get('/updateRejectRequest/{slot_id}', [MainController::class, 'updateRejectRequest'])->name('updateRejectRequest');
    Route::get('/payforParking/{slot_id}', [MainController::class, 'payforParking'])->name('payforParking');

    Route::get('/showAi', [MainController::class, 'showAi'])->name('showAi');
    Route::post('/uploadImages', [MainController::class, 'uploadImages'])->name('uploadImages');
});