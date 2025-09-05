<?php
use App\Http\Controllers\BnBController;

Route::get('/bnbs', [BnBController::class, 'index']);
Route::get('/bnbs/{id}', [BnBController::class, 'show']);
Route::post('/bnbs', [BnBController::class, 'store']);
Route::put('/bnbs/{id}', [BnBController::class, 'update']);
Route::delete('/bnbs/{id}', [BnBController::class, 'destroy']);
