<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { useForm, Link } from '@inertiajs/inertia-vue3';
import Loading from 'vue3-loading-overlay';
import 'vue3-loading-overlay/dist/vue3-loading-overlay.css';
import { ref } from "vue";
import { Inertia } from "@inertiajs/inertia";
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css'

const props = defineProps({
    flash: Object,
    slotsNames: Object,
    slots: Object,
});
let isLoading = ref(false);
let selectedSlot = ref(0);

//function to handle the change of the select option and get the data from the database
const handleSelectChange = (e) => {
    selectedSlot.value = e.target.value;
    Inertia.get('/searchParking', { slot_name: e.target.value }, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        onStart: () => isLoading.value = true,
        onFinish: () => isLoading.value = false,
    });
}

// find the nearest slot to the user's current location
const handleCurrentLocation = () => {
    if (navigator.geolocation) {
        isLoading.value = true;
        navigator.geolocation.getCurrentPosition((position) => {
            let lat = position.coords.latitude;
            let lng = position.coords.longitude;
            let nearestSlot = props.slotsNames[0];
            let nearestDistance = getDistanceFromLatLonInKm(lat, lng, parseFloat(nearestSlot?.latitude), parseFloat(nearestSlot?.longitude));
            props.slotsNames.forEach((slot) => {
                let distance = getDistanceFromLatLonInKm(lat, lng, parseFloat(slot.latitude), parseFloat(slot.longitude));
                if (distance < nearestDistance) {
                    nearestDistance = distance;
                    nearestSlot = slot;
                }
            });

            selectedSlot.value = nearestSlot?.slot_name;
            Inertia.get('/searchParking', { slot_name: nearestSlot?.slot_name }, {
                preserveState: true,
                replace: true,
                preserveScroll: true,
                onStart: () => isLoading.value = true,
                onFinish: () => isLoading.value = false,
            });
        });
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}

// function to calculate the distance between two points
const getDistanceFromLatLonInKm = (lat1, lon1, lat2, lon2) => {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
}

const deg2rad = (deg) => {
    return deg * (Math.PI / 180)
}

function reserveParking(value) {
    new Swal({
        title: 'Reserve Parking Slot',
        text: "A notification will be sent to the owner of the slot!",
        icon: 'success',
        showCancelButton: true,
        cancelButtonColor: '#d33',
        confirmButtonText: 'Send Request',
    }).then((result) => {
        if (result.isConfirmed) {
            setTimeout(() => {
                window.location.href = '/updateSlotReserved/' + value;
            }, 300);
        }
    })
}

</script>
<style scoped>
@import "../../../public/ui/vendor/datatables-bs5/datatables.bootstrap5.css";
</style>
<template>
    <AppLayout title="Dashboard">
        <div class="vld-parent">
            <Loading v-model:active="isLoading" :color="'#696cff'" />
        </div>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card">
                        <div class="card-header border-bottom">
                            <h5 class="card-title">Search for available parking slots</h5>
                            <div class="d-flex justify-content-between align-items-center row py-3 gap-3 gap-md-0">
                                <div class="col-md-4">
                                    <select class="form-select" @change="handleSelectChange" v-model="selectedSlot">
                                        <option value="0" disabled>Select Parking Area...</option>
                                        <option v-for="slots in props.slotsNames" :value="slots.slot_name">
                                            {{ slots.slot_name }}
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-8 mb-3">
                                    <button class="btn btn-primary mt-3" @click="handleCurrentLocation">Use Current
                                        Location</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-datatable table-responsive">
                            <div id="DataTables_Table_0_wrapper" class="dataTables_wrapper dt-bootstrap5 no-footer">
                                <table class="datatables-users table border-top dataTable no-footer dtr-column"
                                    id="DataTables_Table_0" role="grid">
                                    <thead>
                                        <tr role="row">
                                            <th>Slot No</th>
                                            <th>Slot Name</th>
                                            <th>Owners Name</th>
                                            <th>Owners Mobile</th>
                                            <th>Time Until</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="odd" v-for="availablity in props.slots" :key="availablity.id">
                                            <td>
                                                <span class="fw-semibold">{{
                                                        availablity.slot.slot_number
                                                }}</span>
                                            </td>
                                            <td>{{ availablity.slot.slot_name }}</td>
                                            <td><span class="fw-semibold">{{
                                                    availablity.slot.owner_slots[0]?.owner?.full_name
                                            }}</span></td>
                                            <td>{{ availablity.slot.owner_slots[0]?.owner?.mobile_no }}</td>
                                            <td>{{ availablity.time_to }}</td>
                                            <td>
                                                <span v-if="availablity.status == 'Available'"
                                                    class="badge bg-label-primary">{{ availablity.status }}</span>
                                                <span v-if="availablity.status == 'Pending Approval'"
                                                    class="badge bg-label-warning">{{ availablity.status
                                                    }}</span>
                                            </td>
                                            <td>
                                                <div class="d-inline-block text-nowrap">
                                                    <button type="button" class="btn btn-primary"
                                                        @click="reserveParking(availablity.id)"> <i
                                                            class='bx bx-search bx-tada'></i>
                                                        Reserve
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </AppLayout>
</template>