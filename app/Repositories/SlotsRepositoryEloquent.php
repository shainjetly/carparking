<?php

namespace App\Repositories;

use Prettus\Repository\Eloquent\BaseRepository;
use Prettus\Repository\Criteria\RequestCriteria;
use App\Repositories\SlotsRepository;
use App\Models\Slots;
use App\Validators\SlotsValidator;

/**
 * Class SlotsRepositoryEloquent.
 *
 * @package namespace App\Repositories;
 */
class SlotsRepositoryEloquent extends BaseRepository implements SlotsRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Slots::class;
    }

    

    /**
     * Boot up the repository, pushing criteria
     */
    public function boot()
    {
        $this->pushCriteria(app(RequestCriteria::class));
    }
    
}
