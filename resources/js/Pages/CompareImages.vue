<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { useForm } from '@inertiajs/inertia-vue3';

const props = defineProps({
    requests: Object,
    flash: Object,
});

const uploadCompareForm = useForm({
    // originalImage: null,
    cameraImage: null,
});

const UploadCompareFormSubmit = () => {
    uploadCompareForm.post('/uploadImages', {
        preserveScroll: true,
    });
};


</script>

<template>
    <AppLayout title="Dashboard">
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card mb-3">
                        <div class="row">
                            <h5 class="card-header">Demo Parking Cam</h5>
                            <div class="card-body">
                                <form @submit.prevent="UploadCompareFormSubmit">
                                    <!-- <div class="mb-3">
                                        <label for="formFile" class="form-label">Original Image</label>
                                        <input class="form-control" type="file"
                                            @input="uploadCompareForm.originalImage = $event.target.files[0]">
                                    </div> -->
                                    <div class="mb-3">
                                        <label for="formFile" class="form-label">Image from camera</label>
                                        <input class="form-control" type="file"
                                            @input="uploadCompareForm.cameraImage = $event.target.files[0]">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>