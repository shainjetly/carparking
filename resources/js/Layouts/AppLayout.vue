<script setup>
import { ref } from 'vue';
import { Inertia } from '@inertiajs/inertia';
import { Head, Link } from '@inertiajs/inertia-vue3';
import TopMenu from '@/Includes/TopNav.vue';
import SideMenu from '@/Includes/SideMenu.vue';
import Footer from '@/Includes/Footer.vue';

defineProps({
    title: String
});

const logout = () => {
    Inertia.post(route('logout'));
};
</script>

<template>

    <Head :title="title" />
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <SideMenu :user="$page.props.user" />
            <div class="layout-page">
                <TopMenu :user="$page.props.user" />
                <div class="content-wrapper">
                    <slot />
                    <Footer />
                    <div class="content-backdrop fade"></div>
                </div>
            </div>
        </div>
        <div class="layout-overlay layout-menu-toggle"></div>
        <div class="drag-target"></div>
    </div>
</template>