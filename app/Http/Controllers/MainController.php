<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Arr;
use App\Repositories\SlotsRepositoryEloquent;
use App\Repositories\OwnersRepositoryEloquent;
use App\Repositories\OwnerSlotsRepositoryEloquent;
use App\Repositories\ParkingPoolRepositoryEloquent;

/**
 * Class MainController.
 */
class MainController extends Controller {

    protected $slotsRepository;
    protected $ownersRepository;
    protected $ownerSlotsRepository;
    protected $parkingPoolRepository;

    public function __construct(SlotsRepositoryEloquent $slotsRepository, OwnersRepositoryEloquent $ownersRepository, OwnerSlotsRepositoryEloquent $ownerSlotsRepository,  ParkingPoolRepositoryEloquent $parkingPoolRepository) {
        $this->slotsRepository = $slotsRepository;
        $this->ownersRepository = $ownersRepository;
        $this->ownerSlotsRepository = $ownerSlotsRepository;
        $this->parkingPoolRepository = $parkingPoolRepository;
    }

    public function showDashboard() {

        $current_time = date('H:i:s');
        $park = $this->parkingPoolRepository->findWhere(['status' => 'Available']);
        $reserved = $this->parkingPoolRepository->findWhere(['status' => 'Reserved']);

        //loop through the parking pool and check if the current time is between the time_from and time_to
        foreach ($park as $value) {
            if ($value->time_to < $current_time ) {
                $this->parkingPoolRepository->update(['status' => 'NotAvailable'], $value->id);
            }
        }
        
        foreach ($reserved as $valuepark) {
            if ($valuepark->reserved_by != null && $valuepark->time_to < $current_time) {
                $this->parkingPoolRepository->update(['status' => 'Time Expired'], $valuepark->id);
            }
        }
        
        $owner = $this->ownersRepository
                      ->with('ownerslots')
                      ->with('ownerslots.slot')
                      ->with('ownerslots.parkingpool')
                      ->findWhere(['user_id' => auth()->user()->id])->first();

        return Inertia::render('Dashboard', ['owner' => $owner]);
    }

    public function addParking(Request $request) {
        return Inertia::render('AddParking');
    }

    public function storeOwnerSlot(Request $request)
    {
        $ownerCheck = $this->ownersRepository
                      ->findWhere(['idcard_no' => $request->idcard_no, 'mobile_no' => $request->mobile_no])->first();

        if ($ownerCheck?->count()) {
            $this->ownersRepository->update(['user_id' => auth()->user()->id], $ownerCheck->id);
            return redirect()->route('dashboard')->with('message', 'Slots updated, successfully!');
        }
        else{
            return redirect()->route('dashboard')->with('warning', 'No slots found for this user. Please contact City Council!');
        }
        
    }

    public function shareParkingStore(Request $request)
    {
        $timefrom = $request->time_from.':00';
        $timeto = $request->time_to.':00';
        $slotCheck = $this->parkingPoolRepository->findWhere(['slot_id' => $request->slot_id, 'status' => 'Available']);
        if ($slotCheck->first())
        {
            foreach ($slotCheck as $value) {
                if ($timefrom >= $value->time_from && $timeto <= $value->time_to) {
                    return redirect()->back()->with('warning', 'Slot already shared for this time!');
                }else {
                    try {
                        $this->parkingPoolRepository->create($request->all());
                        return redirect()->route('dashboard')->with('message', 'Slot shared, successfully!');
                    } catch (Exception $e) {
                        return redirect()->back()->withErrors($e->getMessageBag())->withInput();
                    }
                }
            }
        }else {
            try {
                $this->parkingPoolRepository->create($request->all());
                return redirect()->route('dashboard')->with('message', 'Slot shared, successfully!');
            } catch (Exception $e) {
                return redirect()->back()->withErrors($e->getMessageBag())->withInput();
            }
        }
    }

    public function searchParking(Request $request)
    {
        $slots = [];
        $slotsNames = \DB::table('slots')->select('slot_name', 'latitude', 'longitude' )->distinct()->get();

        if ($request->slot_name) {
            $getslotids[] = $this->slotsRepository->findWhere(['slot_name' => $request->slot_name]);

           // loop through the array and get the slot_id and push it to another array to use it in the next query
            foreach ($getslotids as $key => $value) {
                foreach ($value as $key => $value) {
                    $getAllslotids[] = $value->id;
                }
            }

            $slots = $this->parkingPoolRepository->scopeQuery(function($query) use ($getAllslotids){
                    return $query->where('status', 'Available')
                                ->with('slot')
                                ->with('slot.ownerSlots')
                                ->with('slot.ownerSlots.owner')
                                 ;
                })->findWhereIn('slot_id', $getAllslotids);

        }
        return Inertia::render('SearchParking', ['slotsNames' => $slotsNames, 'slots' => $slots]);
    }


    public function getSharedSlotsData(Request $request)
    {
        $sharedslots = $this->parkingPoolRepository->findWhere(['slot_id' => $request->slot_id, 'status' => 'Available']);
        if ($request->wantsJson()) {
                return response()->json($sharedslots);
            }
    }

    public function removeSharedSlot($slot_id)
    {   
            $this->parkingPoolRepository->delete($slot_id);
            return redirect()->route('dashboard')->with('message', 'Slot removed, successfully!');
    }

    public function viewRequests()
    {
        // $requests = $this->parkingPoolRepository->with('slot')->with('reservedUser')->findWhere(['status' => 'Available']);

        $requests = $this->parkingPoolRepository->scopeQuery(function($query){
            return $query
                        ->with('slot')
                        ->with('reservedUser')
                        ->where('status', 'Pending Approval')
                        ->orWhere('status', 'Reserved')
                        ->orWhere('status', 'Time Expired')
                        ;
        })->all();

        return Inertia::render('ViewRequests', ['requests' => $requests]);
    }

    public function updateSlotReserved($slot_id)
    {
        $this->parkingPoolRepository->update(['status' => 'Pending Approval', 'reserved_by' => auth()->user()->id ], $slot_id);
        return redirect()->back()->with('message', 'A notification has been sent to the owner! Once the owner approves your request, you will be notified!');
    }

    public function myRequests()
    {
        $requests = $this->parkingPoolRepository->with('slot')->with('slot.ownerSlots.owner')->findWhere(['reserved_by' => auth()->user()->id]);
        return Inertia::render('MyRequests', ['requests' => $requests]);
    }

    public function updateApproveRequest($slot_id)
    {
        $this->parkingPoolRepository->update(['status' => 'Payment'], $slot_id);
        return redirect()->back()->with('message', 'Request approved, successfully!');
    }

    public function updateRejectRequest($slot_id)
    {
        $this->parkingPoolRepository->update(['status' => 'Available', 'reserved_by' => null], $slot_id);
        return redirect()->back()->with('message', 'Request rejected, successfully!');
    }

    public function payforParking($slot_id)
    {
        $this->parkingPoolRepository->update(['status' => 'Reserved'], $slot_id);
        return redirect()->back()->with('message', 'Payment done, successfully!');
    }

    //function to php ai image comparison alogrithm
    public function compareImages($image1, $image2)
    {
        $image1 = imagecreatefromjpeg($image1);
        $image2 = imagecreatefromjpeg($image2);

        $width1 = imagesx($image1);
        $width2 = imagesx($image2);
        $height1 = imagesy($image1);
        $height2 = imagesy($image2);

        $min_width = min($width1, $width2);
        $min_height = min($height1, $height2);

        $diff = 0;

        for ($y = 0; $y < $min_height; $y++) {
            for ($x = 0; $x < $min_width; $x++) {
                $rgb1 = imagecolorat($image1, $x, $y);
                $rgb2 = imagecolorat($image2, $x, $y);
                $r1 = ($rgb1 >> 16) & 0xFF;
                $g1 = ($rgb1 >> 8) & 0xFF;
                $b1 = $rgb1 & 0xFF;
                $r2 = ($rgb2 >> 16) & 0xFF;
                $g2 = ($rgb2 >> 8) & 0xFF;
                $b2 = $rgb2 & 0xFF;
                $diff += abs($r1 - $r2);
                $diff += abs($g1 - $g2);
                $diff += abs($b1 - $b2);
            }
        }

        $total = $min_width * $min_height * 3;
        $percent = 100 - ($diff / $total * 100);
        return $percent;
    }


    public function showAi()
    {
        return Inertia::render('CompareImages');
    }

    public function uploadImages(Request $request)
    {

        // $image1 = $request->file('originalImage');
        $image2 = $request->file('cameraImage');

        // $imageName1 = time().'.'.$image1->extension();
        $imageName2 = time().'.'.$image2->extension();

        // $image1->move(public_path('img'), $imageName1);
        $image2->move(public_path('img'), $imageName2);

        $image1 = "/Users/saameen/Documents/www/ec/public/img/B1A6298_06.jpg";
        $image2 = public_path('img/'.$imageName2);


        $percent = $this->compareImages($image1, $image2);

        if ($percent < 100 ) {
            $this->parkingPoolRepository->update(['ai_status' => 'Someone has just parked in this slot.' ], 46);
        }

        return redirect()->back()->with('message', 'The images are '.$percent.'% similar');
    }

}