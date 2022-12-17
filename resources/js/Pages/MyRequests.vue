<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css'

const props = defineProps({
    requests: Object,
    flash: Object,
});

function payforParking(value) {
    new Swal({
        title: 'Pay for Parking',
        text: "You will be redirected to the payment page.",
        icon: 'success',
        showCancelButton: true,
        cancelButtonColor: '#d33',
        confirmButtonText: 'Send Request',
    }).then((result) => {
        if (result.isConfirmed) {
            setTimeout(() => {
                window.location.href = '/payforParking/' + value;
            }, 300);
        }
    })
}

</script>

<template>
    <AppLayout title="Dashboard">
        <div class="container-xxl flex-grow-1 container-p-y">
            <div class="row">
                <div class="col-lg-12 mb-4">
                    <div class="card mb-3">
                        <div class="row">
                            <div class="card-body">
                                <div class="card-datatable table-responsive">
                                    <div id="DataTables_Table_0_wrapper"
                                        class="dataTables_wrapper dt-bootstrap5 no-footer">
                                        <table class="datatables-users table border-top dataTable no-footer dtr-column"
                                            id="DataTables_Table_0" role="grid">
                                            <thead>
                                                <tr role="row">
                                                    <th>Slot No</th>
                                                    <th>Slot Name</th>
                                                    <th>Owners Name</th>
                                                    <th>Owners Mobile</th>
                                                    <th>Time Until</th>
                                                    <th>Status</th>
                                                    <th>Notify</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="odd" v-for="myrequest in props.requests" :key="myrequest.id">
                                                    <td>
                                                        <span class="fw-semibold">{{
                                                                myrequest.slot.slot_number
                                                        }}</span>
                                                    </td>
                                                    <td>{{ myrequest.slot.slot_name }}</td>
                                                    <td><span class="fw-semibold">{{
                                                            myrequest.slot.owner_slots[0].owner.full_name
                                                    }}</span></td>
                                                    <td>{{ myrequest.slot.owner_slots[0].owner.mobile_no }}</td>
                                                    <td>{{ myrequest.time_to }}</td>
                                                    <td>
                                                        <span v-if="myrequest.status != 'Reserved'"
                                                            class="badge bg-label-warning">{{
                                                                    myrequest.status
                                                            }}</span>
                                                        <span v-else class="badge bg-label-success">
                                                            {{ myrequest.status }}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        {{ myrequest.ai_status }}
                                                    </td>
                                                    <td>
                                                        <button v-if="myrequest.status == 'Payment'"
                                                            class="btn btn-sm btn-outline-danger"
                                                            @click="payforParking(myrequest.id)">
                                                            Pay
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
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