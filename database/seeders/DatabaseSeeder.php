<?php

namespace Database\Seeders;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            'name' => 'Mohamed Saameen',
            'email' => 'shaamin@gmail.com',
            'password' => Hash::make('welcome@123'),
        ]);
    }
}
