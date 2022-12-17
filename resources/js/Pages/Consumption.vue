<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { ref, watch } from "vue";
import { Inertia } from '@inertiajs/inertia';

defineProps({
    consData: String
});

let yearfilter = ref('None');

watch(yearfilter, value => {
    Inertia.get('/filteryear', { yearfilter: value }, { preserveState: true });
});

</script>

<template>
    <AppLayout title="Consumption Page">
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">

                <div class="col-xl-12 col-12 mb-4">
                    <div class="card">

                        <h5 class="card-header">Monthly Cost & Consumption</h5>

                        <div class="table-responsive text-nowrap">

                            <div class="row" style="padding: 10px;">
                                <div class="col-sm-2 col-md-2">
                                    <div class="dataTables_length" id="DataTables_Table_3_length">
                                        <label>Sort by Year</label>
                                        <select v-model="yearfilter" name="DataTables_Table_3_length"
                                            aria-controls="DataTables_Table_3" class="form-select form-select-sm">
                                            <option value="None">None</option>
                                            <option value="2022">2022</option>
                                            <option value="2021">2021</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Year/Month</th>
                                        <th>Meter Number</th>
                                        <th>Consumption/kWh</th>
                                        <th>kWh Charges</th>
                                        <th>Total Outstanding</th>
                                    </tr>
                                </thead>
                                <tbody class="table-border-bottom-0">

                                    <tr v-for="kwh in consData">
                                        <td>{{ kwh.revenue_month }}</td>
                                        <td>{{ kwh.meter_number }}</td>
                                        <td>{{ kwh.consumption_kwh }}</td>
                                        <td>{{ kwh.kwh_charges }}</td>
                                        <td><span class="badge bg-label-primary me-1">{{
                                                kwh.current_charges
                                        }}</span></td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

            </div>


        </div>
    </AppLayout>
</template>