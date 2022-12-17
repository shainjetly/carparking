<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import UpdatePasswordForm from '@/Pages/Profile/Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from '@/Pages/Profile/Partials/UpdateProfileInformationForm.vue';

defineProps({
    confirmsTwoFactorAuthentication: Boolean,
    sessions: Array,
});
</script>

<template>
    <AppLayout title="Profile">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Profile
            </h2>
        </template>

        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card">
                        <div class="card-body row g-4" v-if="$page.props.jetstream.canUpdateProfileInformation">
                            <UpdateProfileInformationForm :user="$page.props.user" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12 mb-4">
                    <div class="card">
                        <div class="card-body row g-4" v-if="$page.props.jetstream.canUpdatePassword">
                            <UpdatePasswordForm class="mt-10 sm:mt-0" />

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>
