<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { useForm, Link } from '@inertiajs/inertia-vue3';
import Loading from 'vue3-loading-overlay';
import 'vue3-loading-overlay/dist/vue3-loading-overlay.css';
import { ref } from "vue";

const props = defineProps({
    flash: Object,
    user: Object,
});

let isLoading = ref(false);
const SlotAddForm = useForm({
    idcard_no: '',
    mobile_no: props.user.mobile_number,
});

const SlotAddFormSubmit = () => {
    SlotAddForm.post('/storeOwnerSlot', {
        preserveScroll: true,
        onStart: () => isLoading.value = true,
        onFinish: () => isLoading.value = false,
    });
};

</script>

<template>
    <AppLayout title="Dashboard">
        <div class="vld-parent">
            <Loading v-model:active="isLoading" :color="'#696cff'" />
        </div>
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card">
                        <div class="row">
                            <div class="col-sm-7">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">Add Parking Slots</h5>
                                    <small class="text-muted float-end">Data from City Council Database</small>
                                </div>
                                <div class="card-body">
                                    <form @submit.prevent="SlotAddFormSubmit">
                                        <div class="mb-3">
                                            <label class="form-label" for="basic-default-company">ID Card No</label>
                                            <input type="text" class="form-control" id="basic-default-company"
                                                placeholder="A125328" v-model="SlotAddForm.idcard_no" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="basic-default-phone">Mobile No</label>
                                            <input type="text" class="form-control phone-mask" placeholder="7917008"
                                                v-model="SlotAddForm.mobile_no" disabled required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </form>
                                </div>
                            </div>
                            <div class="col-sm-5 text-center text-sm-left">
                                <div class="card mb-4">
                                    <img class="card-img-top" src="/img/public-park.jpg" alt="Card image cap">
                                    <div class="card-body">
                                        <p class="card-text">
                                            Here you can add the parking slot that you have already registered at City
                                            Council. If you dont have a slot please contact the City Council.
                                        </p>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </AppLayout>
</template>