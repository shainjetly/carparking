<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import dayjs from 'dayjs';
import advancedFormat from 'dayjs/plugin/advancedFormat';
import { GoogleMap, CustomMarker } from 'vue3-google-map';
import FlatPickr from 'vue-flatpickr-component';
import { ref } from "vue";
import Loading from 'vue3-loading-overlay';
import 'vue3-loading-overlay/dist/vue3-loading-overlay.css';
import { useForm, Link } from '@inertiajs/inertia-vue3';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css'

const props = defineProps({
    owner: Object,
    flash: Object,
});
dayjs.extend(advancedFormat);
let isLoading = ref(false);
let sharedSlots = ref([]);
const time_fromArr = ref({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    minTime: dayjs().format('HH:mm'),
    maxTime: "23:59",
    defaultDate: dayjs().format('HH:mm'),
});
const time_toArr = ref({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    minTime: dayjs().format('HH:mm'),
    maxTime: "23:59",
    defaultDate: dayjs().format('HH:mm'),
});

const ShareParkingAddForm = useForm({
    time_from: dayjs().format('HH:mm'),
    time_to: dayjs().format('HH:mm'),
    slot_id: '',
    status: 'Available',
});

const ShareParkingAddFormSubmit = () => {
    ShareParkingAddForm.post('/shareParkingStore', {
        preserveScroll: true,
        onStart: () => isLoading.value = true,
        onFinish: () => {
            isLoading.value = false;
            document.getElementById('shareParkingModal').classList.remove('show');
            document.getElementsByClassName('modal-backdrop')[0].classList.remove('modal-backdrop');
        }
    });
};

//function to open shareParkingModal modal
const shareParkingModal = ref(null);

const openShareParkingModal = (slot_id) => {
    ShareParkingAddForm.slot_id = slot_id;
}

const getSharedSlots = (value) => {
    //make axios call to get all the shared slots based on slot_id
    axios.get("/getSharedSlotsData", {
        params: {
            slot_id: value
        }
    }).then((response) => {
        if (response.data) {
            sharedSlots.value = response.data;
        }
    });
}

function removeSharing(value) {
    document.getElementById('showSharedSlotsModal').classList.remove('show');
    document.getElementsByClassName('modal-backdrop')[0].classList.remove('modal-backdrop');
    new Swal({
        title: 'Are you sure?',
        text: "This slot will be removed from the shared slots list!",
        icon: 'warning',
        showCancelButton: true,
        cancelButtonColor: '#d33',
        confirmButtonText: 'I am sure!'
    }).then((result) => {
        if (result.isConfirmed) {
            setTimeout(() => {
                window.location.href = '/removeSharedSlot/' + value;
            }, 300);
        }
    })
}

</script>
<style scoped>
@import 'flatpickr/dist/themes/material_orange.css';
</style>
<template>
    <AppLayout title="Dashboard">
        <div class="vld-parent">
            <Loading v-model:active="isLoading" :color="'#696cff'" />
        </div>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div v-if="props.flash.message" class="alert alert-primary alert-dismissible" role="alert">
                {{ props.flash.message }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div v-if="props.flash.warning" class="alert alert-danger alert-dismissible" role="alert">
                {{ props.flash.warning }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card mb-3" v-if="owner !== null" v-for="slots in owner?.ownerslots" :key="slots.id">
                        <div class="row">
                            <div class="col-sm-5">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">Parking Slot: {{ slots.slot.slot_number }}</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-2">Owner Name: <span class="fw-bold text-primary">{{ owner?.full_name
                                    }}</span></div>
                                    <div class="mb-2">Mobile No: <span class="fw-bold text-primary">{{ owner?.mobile_no
                                    }}</span></div>
                                    <div class="mb-2">ID Card No: <span class="fw-bold text-primary">{{ owner?.idcard_no
                                    }}</span></div>
                                    <div class="mb-2">Registered On: <span class="fw-bold text-primary">{{
                                            dayjs(owner?.created_at).format('Do MMMM YYYY')
                                    }}</span>
                                    </div>
                                    <div class="mb-2">Slot Name: <span class="fw-bold text-primary">{{
                                            slots.slot?.slot_name
                                    }}</span>
                                    </div>
                                    <div>Ward: <span class="fw-bold text-primary">{{ slots.slot?.ward }}</span></div>

                                    <span class="px-0">

                                        <button type="button" class="btn btn-primary m-3" data-bs-toggle="modal"
                                            data-bs-target="#shareParkingModal"
                                            @click="openShareParkingModal(slots.slot.id)"> <i
                                                class='bx bx-plus bx-tada'></i>
                                            Share Slot
                                        </button>

                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#showSharedSlotsModal"
                                            @click="getSharedSlots(slots.slot.id)"> <i class='bx bx-search bx-tada'></i>
                                            View Shared Status
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-7 text-center">
                                <div class="card-body">
                                    <GoogleMap api-key="AIzaSyD1kzKNbguUnb_jI5o7kF0-kNFUk3MFSU8"
                                        style="width: 100%; height: 300px"
                                        :center="{ lat: parseFloat(slots.slot.latitude), lng: parseFloat(slots.slot.longitude) }"
                                        :zoom="20">
                                        <CustomMarker
                                            :options="{ position: { lat: parseFloat(slots.slot.latitude), lng: parseFloat(slots.slot.longitude) } }">
                                            <div style="text-align: center">
                                                <div style="font-size: 1.125rem; color: red;">{{ slots.slot.slot_name }}
                                                </div>
                                                <img src="/img/map-marker.png" width="30" height="45"
                                                    style="margin-top: 8px" />
                                            </div>
                                        </CustomMarker>
                                    </GoogleMap>
                                </div>
                                <div class="card-body">
                                    <img :src="'/img/' + slots.slot.image" height="200" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-3" v-else>
                        <div class="row">
                            <div class="card-body">
                                <div class="mb-2 text-danger">No Slots are Registered under your name. Go to Add Parking
                                    Slot to
                                    add a Slot.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="shareParkingModal" tabindex="-1" aria-modal="true" role="dialog" ref="modalShow">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Sharing Parking Slot</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <hr>
                    <form @submit.prevent="ShareParkingAddFormSubmit">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col mb-3">
                                    <label for="name" class="form-label"><b>Share from</b></label>
                                    <FlatPickr :config="time_fromArr" class="form-control" placeholder="Share from time"
                                        name="time_from" v-model="ShareParkingAddForm.time_from" />
                                </div>
                                <div class="col mb-3">
                                    <label for="name" class="form-label"><b>Share to</b></label>
                                    <FlatPickr :config="time_toArr" class="form-control" placeholder="Share to time"
                                        name="time_to" v-model="ShareParkingAddForm.time_to" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">
                                Close
                            </button>
                            <button type="submit" class="btn btn-primary">Share</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="showSharedSlotsModal" tabindex="-1" aria-modal="true" role="dialog" ref="modalShow">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Shared Timings</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <hr>
                    <div class="modal-body">
                        <div class="card">
                            <div class="table-responsive text-nowrap">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>From</th>
                                            <th>To</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="table-border-bottom-0">
                                        <tr v-for="shared in sharedSlots">
                                            <td>
                                                {{ shared.time_from }}
                                            </td>
                                            <td>{{ shared.time_to }}</td>
                                            <td>
                                                <div>
                                                    <Link class="btn btn-sm btn-danger"
                                                        @click="removeSharing(shared.id)"><i
                                                        class="bx bx-trash me-1"></i>
                                                    Cancel Sharing</Link>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </AppLayout>
</template>