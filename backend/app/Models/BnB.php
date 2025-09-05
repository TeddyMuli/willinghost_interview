<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BnB extends Model
{
	protected $fillable = [
		'name',
		'location',
		'price_per_night',
		'availability',
	];
}
