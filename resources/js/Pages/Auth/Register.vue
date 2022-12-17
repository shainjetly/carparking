<script setup>
import { Head, Link, useForm } from '@inertiajs/inertia-vue3';
import HsAuthenticationCard from '@/Components/AuthenticationCard.vue';
import HsAuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import HsButton from '@/Components/Button.vue';
import HsInput from '@/Components/Input.vue';
import HsValidationErrors from '@/Components/ValidationErrors.vue';

const form = useForm({
    name: '',
    email: '',
    mobile_number: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>

    <Head title="Register" />

    <HsAuthenticationCard>

        <div class="card">
            <div class="card-body">
                <HsAuthenticationCardLogo />

                <HsValidationErrors class="mb-4" />

                <form @submit.prevent="submit" class="mb-3 fv-plugins-bootstrap5 fv-plugins-framework">
                    <div>

                        <label for="name" class="form-label">Name</label>
                        <HsInput id="name" v-model="form.name" type="text" class="form-control" required autofocus
                            autocomplete="name" />
                    </div>

                    <div class="mt-4">
                        <label for="email" class="form-label">Email</label>
                        <HsInput id="email" v-model="form.email" type="email" class="form-control" required />
                    </div>

                    <div class="mt-4">
                        <label for="email" class="form-label">Mobile Number</label>
                        <HsInput id="mobile_number" v-model="form.mobile_number" type="text" class="form-control"
                            required />
                    </div>

                    <div class="mt-4">
                        <label for="password" class="form-label">Password</label>
                        <HsInput id="password" v-model="form.password" type="password" class="form-control" required
                            autocomplete="new-password" />
                    </div>

                    <div class="mt-4">
                        <label for="password_confirmation" class="form-label">Confirm Password</label>
                        <HsInput id="password_confirmation" v-model="form.password_confirmation" type="password"
                            class="form-control" required autocomplete="new-password" />
                    </div>

                    <div class="flex items-center justify-end mt-4">
                        <Link :href="route('login')" class="underline text-sm text-gray-600 hover:text-gray-900">
                        Already registered?
                        </Link>

                        <HsButton class="btn btn-info" :class="{ 'opacity-25': form.processing }"
                            :disabled="form.processing">
                            Register
                        </HsButton>
                    </div>
                </form>
            </div>
        </div>
    </HsAuthenticationCard>
</template>
