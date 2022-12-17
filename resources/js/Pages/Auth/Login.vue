<script setup>
import { Head, Link, useForm } from '@inertiajs/inertia-vue3';
import HsAuthenticationCard from '@/Components/AuthenticationCard.vue';
import HsAuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import HsButton from '@/Components/Button.vue';
import HsInput from '@/Components/Input.vue';
import HsCheckbox from '@/Components/Checkbox.vue';
import HsValidationErrors from '@/Components/ValidationErrors.vue';

defineProps({
    canResetPassword: Boolean,
    status: String,
    minLength: Number
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});


const submit = () => {
    form.transform(data => ({
        ...data,
        remember: form.remember ? 'on' : '',
    })).post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>

    <Head title="Sign in to your account" />

    <HsAuthenticationCard>
        <!-- Login -->
        <div class="card">
            <div class="card-body">
                <!-- Logo -->
                <HsAuthenticationCardLogo />
                <!-- /Logo -->
                <h4 class="mb-2">Login</h4>
                <p class="mb-4">Sign in to your account for a parking space.</p>
                <HsValidationErrors class="mb-0" />
                <div v-if="status" class="mb-4 font-medium text-sm text-green-600">
                    {{ status }}
                </div>

                <form @submit.prevent="submit" class="mb-3 fv-plugins-bootstrap5 fv-plugins-framework">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email address</label>
                        <HsInput type="email" id="email" v-model="form.email" class="form-control"
                            placeholder="Enter your email address" required autofocus tabindex="1" />
                    </div>
                    <div class="mb-3 form-password-toggle">
                        <div class="d-flex justify-content-between">
                            <label class="form-label" for="password">Password</label>
                        </div>
                        <div class="input-group input-group-merge">
                            <HsInput id="password" v-model="form.password" type="password" class="form-control"
                                placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                                aria-describedby="password" required autocomplete="current-password" tabindex="2" />
                        </div>
                    </div>
                    <HsButton class="btn btn-primary d-grid w-100" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing">
                        Sign in
                    </HsButton>

                </form>

                <p class="text-center">
                    <span>New Cusomers</span>
                    <a href="/register">
                        <span>Create an account</span>
                    </a>
                </p>
            </div>
        </div>
    </HsAuthenticationCard>
</template>