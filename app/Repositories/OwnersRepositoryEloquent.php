<?php

namespace App\Repositories;

use Prettus\Repository\Eloquent\BaseRepository;
use Prettus\Repository\Criteria\RequestCriteria;
use App\Repositories\OwnersRepository;
use App\Models\Owners;
use App\Validators\OwnersValidator;

/**
 * Class OwnersRepositoryEloquent.
 *
 * @package namespace App\Repositories;
 */
class OwnersRepositoryEloquent extends BaseRepository implements OwnersRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Owners::class;
    }

    

    /**
     * Boot up the repository, pushing criteria
     */
    public function boot()
    {
        $this->pushCriteria(app(RequestCriteria::class));
    }
    
}
