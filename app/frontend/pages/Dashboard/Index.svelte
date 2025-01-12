<script lang="ts">
  import type { Customer, Invoice } from '$types/typelizer'

  import TodayCustomerTable from './components/TodayCustomerTable.svelte'
  import TodayInvoiceTable from './components/TodayInvoiceTable.svelte'
  import TodayItemTable from './components/TodayItemTable.svelte'

  let {
    invoices,
    customers,
  }: {
    invoices: Invoice[]
    customers: Customer[]
  } = $props()

  let items = $derived.by(() => invoices?.flatMap((invoice) => invoice.items))
</script>

<div class="flex size-full flex-col items-center py-8 gap-4">
  <h2 class="text-2xl font-bold">Invoice Hari Ini</h2>
  <TodayInvoiceTable {invoices} />
  <h2 class="text-2xl font-bold">Pelanggan Hari Ini</h2>
  <TodayCustomerTable {customers} />
  <h2 class="text-2xl font-bold">Barang Hari Ini</h2>
  <TodayItemTable {items} />
</div>
