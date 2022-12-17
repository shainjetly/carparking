<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Contracts\Transformable;
use Prettus\Repository\Traits\TransformableTrait;

/**
 * Class Slots.
 *
 * @package namespace App\Entities;
 */
class Slots extends Model implements Transformable
{
    use TransformableTrait;
    protected $table = "slots";
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['slot_name', 'ward', 'slot_number', 'latitude', 'longitude', 'image'];

    public function ownerSlots()
    {
        return $this->hasMany(OwnerSlots::class, 'slot_id', 'id');
    }

    public function owner()
    {
        return $this->belongsTo(Owners::class, 'owner_id', 'id');
    }

    public function parkingPool()
    {
        return $this->hasMany(ParkingPool::class, 'slot_id', 'id');
    }
}
