<script setup>
import { computed } from 'vue';
import { usePage } from '@inertiajs/inertia-vue3';

const errors = computed(() => usePage().props.value.errors);
const hasErrors = computed(() => Object.keys(errors.value).length > 0);
</script>

<template>
    <div v-if="hasErrors" class="alert alert-danger alert-dismissible" role="alert">
        <div class="alert-heading d-flex align-items-center fw-bold mb-1">
            Whoops! Something went wrong.
        </div>

        <ul class="mb-0">
            <li v-for="(error, key) in errors" :key="key">
                {{ error }}
            </li>
        </ul>
    </div>
</template>
