<script setup>
import { Link } from '@inertiajs/inertia-vue3';

const props = defineProps({
    user: Object,
    flash: Object,
});

</script>

<template>
    <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
        <div class="app-brand demo">
            <a href="/" class="app-brand-link">
                <h3>ShareMyParking</h3>
            </a>
        </div>
        <div class="menu-inner-shadow"></div>
        <ul class="menu-inner py-1">
            <li :class="{ 'active': $page.url === '/dashboard' || $page.url === '/' }" class="menu-item">
                <Link :href="route('dashboard')" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div>Dashboard</div>
                </Link>
            </li>

            <li class="menu-header small text-uppercase">
                <span class="menu-header-text">Manage Parking</span>
            </li>
            <li :class="{ 'active': $page.url === '/addParking' }" class="menu-item">
                <Link :href="route('addParking')" class="menu-link">
                <i class="menu-icon tf-icons bx bx-map"></i>
                <div>Add Parking Slot</div>
                </Link>
            </li>
            <li :class="{ 'active': $page.component.startsWith('SearchParking') }" class="menu-item">
                <Link :href="route('searchParking')" class="menu-link">
                <i class="menu-icon tf-icons bx bx-car"></i>
                <div>Search Parking</div>
                </Link>
            </li>
            <li v-if="props.user.mobile_number == '7917008'"
                :class="{ 'active': $page.component.startsWith('ViewRequests') }" class="menu-item">
                <Link :href="route('viewRequests')" class="menu-link">
                <i class="menu-icon tf-icons bx bx-ghost"></i>
                <div>View Requests</div>
                </Link>
            </li>
            <li :class="{ 'active': $page.component.startsWith('MyRequests') }" class="menu-item">
                <Link :href="route('myRequests')" class="menu-link">
                <i class="menu-icon tf-icons bx bx-ghost"></i>
                <div>My Requests</div>
                </Link>
            </li>
        </ul>
    </aside>
</template>