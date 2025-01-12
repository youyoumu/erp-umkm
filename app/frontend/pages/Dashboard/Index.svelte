<script lang="ts">
  import type { Customer, Invoice } from '$types/typelizer'

  import TodayInvoiceTable from './components/TodayInvoiceTable.svelte'

  let {
    invoices,
  }: {
    invoices: Invoice[]
    customers: Customer[]
  } = $props()
</script>

<div class="flex size-full flex-col items-center py-8 gap-4">
  <h2 class="text-2xl font-bold">Invoice Hari Ini</h2>
  <TodayInvoiceTable {invoices} />
</div>
