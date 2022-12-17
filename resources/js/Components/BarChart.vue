<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
    name: 'BarChart',
    components: { Bar },
    data: () => ({
        loaded: false,
        chartData: null
    }),
    async mounted() {
        this.loaded = false

        try {
            const { userlist } = await fetch('https://data.cityofnewyork.us/resource/jr24-e7cr.json?meter_number=5648157')
            this.chartdata = userlist
            console.log(this.userlist);
            this.loaded = true
        } catch (e) {
            console.error(e)
        }
    }
}
</script>