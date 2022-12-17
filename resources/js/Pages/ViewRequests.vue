<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css'

const props = defineProps({
    requests: Object,
    flash: Object,
});

function approveRequest(value) {
    new Swal({
        title: 'Approve Request',
        text: "Request will be approved and the slot will be reserved for the user.",
        icon: 'success',
        showCancelButton: true,
        cancelButtonColor: '#d33',
        confirmButtonText: 'Approve Request',
    }).then((result) => {
        if (result.isConfirmed) {
            setTimeout(() => {
                window.location.href = '/updateApproveRequest/' + value;
            }, 300);
        }
    })
}

function rejectParking(value) {
    new Swal({
        title: 'Reject Request',
        text: "Request will be rejected and the slot will be available for other users.",
        icon: 'error',
        showCancelButton: true,
        cancelButtonColor: '#d33',
        confirmButtonText: 'Reject Request',
    }).then((result) => {
        if (result.isConfirmed) {
            setTimeout(() => {
                window.location.href = '/updateRejectRequest/' + value;
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
                                                    <th>Requested By</th>
                                                    <th>Requester Mobile</th>
                                                    <th>Time Until</th>
                                                    <th>Status</th>
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
                                                    <td>{{ myrequest?.reserved_user?.name }}</td>
                                                    <td>{{ myrequest.reserved_user?.mobile_number }}</td>
                                                    <td>{{ myrequest.time_to }}</td>
                                                    <td>
                                                        <span class="badge bg-label-warning">{{
                                                                myrequest.status
                                                        }}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-inline-block text-nowrap">
                                                            <button v-if="myrequest.status != 'Time Expired'"
                                                                type="button" class="btn btn-primary"
                                                                @click="approveRequest(myrequest.id)"> <i
                                                                    class='bx bx-play bx-tada'></i>
                                                                Approve
                                                            </button>
                                                            <span class="m-1"></span>
                                                            <button v-if="myrequest.status != 'Time Expired'"
                                                                type="button" class="btn btn-danger"
                                                                @click="rejectParking(myrequest.id)"> <i
                                                                    class='bx bx-message-square-x bx-tada'></i>
                                                                Reject
                                                            </button>
                                                        </div>
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