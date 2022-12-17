<?php

namespace App\Repositories;

use Prettus\Repository\Eloquent\BaseRepository;
use Prettus\Repository\Criteria\RequestCriteria;
use App\Repositories\ParkingPoolRepository;
use App\Models\ParkingPool;
use App\Validators\ParkingPoolValidator;

/**
 * Class ParkingPoolRepositoryEloquent.
 *
 * @package namespace App\Repositories;
 */
class ParkingPoolRepositoryEloquent extends BaseRepository implements ParkingPoolRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return ParkingPool::class;
    }

    

    /**
     * Boot up the repository, pushing criteria
     */
    public function boot()
    {
        $this->pushCriteria(app(RequestCriteria::class));
    }
    
}
