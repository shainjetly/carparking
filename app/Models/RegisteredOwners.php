<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Contracts\Transformable;
use Prettus\Repository\Traits\TransformableTrait;

/**
 * Class RegisteredOwners.
 *
 * @package namespace App\Models;
 */
class RegisteredOwners extends Model implements Transformable
{
    use TransformableTrait;
    protected $table = "registered_owners";
    public $timestamps = false;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['owners_id', 'slot_id'];

    public function owner() {
        return $this->belongsTo('App\Models\Owners', "owners_id");
    }

    public function slot() {
        return $this->belongsTo('App\Models\Slots', "slot_id");
    }
}
