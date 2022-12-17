<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Contracts\Transformable;
use Prettus\Repository\Traits\TransformableTrait;

/**
 * Class Owners.
 *
 * @package namespace App\Models;
 */
class Owners extends Model implements Transformable
{
    use TransformableTrait;
    protected $table = "owners_api";
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['full_name', 'mobile_no', 'idcard_no', 'user_id'];

    public function ownerslots() {
        return $this->hasMany('App\Models\OwnerSlots', "owners_id");
    }

    public function registeredowners() {
        return $this->hasMany('App\Models\RegisteredOwners', "owners_id");
    }
}
