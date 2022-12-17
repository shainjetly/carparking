<?php

namespace App\Repositories;

use Prettus\Repository\Eloquent\BaseRepository;
use Prettus\Repository\Criteria\RequestCriteria;
use App\Repositories\RegisteredOwnersRepository;
use App\Models\RegisteredOwners;
use App\Validators\RegisteredOwnersValidator;

/**
 * Class RegisteredOwnersRepositoryEloquent.
 *
 * @package namespace App\Repositories;
 */
class RegisteredOwnersRepositoryEloquent extends BaseRepository implements RegisteredOwnersRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return RegisteredOwners::class;
    }

    

    /**
     * Boot up the repository, pushing criteria
     */
    public function boot()
    {
        $this->pushCriteria(app(RequestCriteria::class));
    }
    
}
