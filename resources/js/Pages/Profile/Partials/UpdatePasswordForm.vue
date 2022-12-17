<script setup>
import { ref } from 'vue';
import { useForm } from '@inertiajs/inertia-vue3';
import JetActionMessage from '@/Jetstream/ActionMessage.vue';
import JetButton from '@/Components/Button.vue';
import JetFormSection from '@/Jetstream/FormSection.vue';
import JetInput from '@/Components/Input.vue';
import JetInputError from '@/Jetstream/InputError.vue';
import JetLabel from '@/Jetstream/Label.vue';

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('user-password.update'), {
        errorBag: 'updatePassword',
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }

            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>

<template>
    <JetFormSection @submitted="updatePassword">
        <template #title>
            Update Password
        </template>

        <template #description>
            Ensure your account is using a long, random password to stay secure.
        </template>

        <template #form>
            <div class="mb-3 col-lg-3">
                <JetLabel for="current_password" value="Current Password" />
                <JetInput id="current_password" ref="currentPasswordInput" v-model="form.current_password"
                    type="password" class="form-control" autocomplete="current-password" />
                <JetInputError :message="form.errors.current_password" class="mt-2" />
            </div>

            <div class="mb-3 col-lg-3">
                <JetLabel for="password" value="New Password" />
                <JetInput id="password" ref="passwordInput" v-model="form.password" type="password" class="form-control"
                    autocomplete="new-password" />
                <JetInputError :message="form.errors.password" class="mt-2" />
            </div>

            <div class="col-lg-3">
                <JetLabel for="password_confirmation" value="Confirm Password" />
                <JetInput id="password_confirmation" v-model="form.password_confirmation" type="password"
                    class="form-control" autocomplete="new-password" />
                <JetInputError :message="form.errors.password_confirmation" class="mt-2" />
            </div>
        </template>

        <template #actions>
            <JetActionMessage :on="form.recentlySuccessful" class="mr-3 text-primary">
                Saved.
            </JetActionMessage>

            <JetButton class="btn btn-primary" :class="{ 'opacity-25': form.processing }" :disabled="form.processing">
                Save
            </JetButton>
        </template>
    </JetFormSection>
</template>
