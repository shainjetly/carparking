<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Prettus\Repository\Contracts\Transformable;
use Prettus\Repository\Traits\TransformableTrait;

/**
 * Class ParkingPool.
 *
 * @package namespace App\Models;
 */
class ParkingPool extends Model implements Transformable
{
    use TransformableTrait;
    protected $table = "parking_pool";
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['slot_id', 'time_from', 'time_to', 'status', 'reserved_by', 'ai_status'];

    public function slot()
    {
        return $this->belongsTo('App\Models\Slots', 'slot_id', 'id');
    }

    //reserved user from users table
    public function reservedUser()
    {
        return $this->belongsTo('App\Models\User', 'reserved_by', 'id');
    }
}
