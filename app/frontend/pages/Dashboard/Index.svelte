<script>
  import { Construction } from 'lucide-svelte'

  let { invoices, customers } = $props()
  $inspect(customers)
</script>

<div class="flex size-full flex-col items-center justify-center">
  <Construction class="h-24 w-24 " />
  <div class="text-2xl">Work in progress</div>
</div>
