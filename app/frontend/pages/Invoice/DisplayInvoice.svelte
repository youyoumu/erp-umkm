<script lang="ts">
  let { invoice_id, host_with_port } = $props()
  import { LoaderIcon } from 'lucide-svelte'

  async function downloadInvoice() {
    const res = await fetch(
      `http://${host_with_port}/invoices/${invoice_id}/download_invoice`
    )
    const blob = await res.blob()
    const file = URL.createObjectURL(blob)
    return file
  }
</script>

{#await downloadInvoice()}
  <div
    class="absolute left-0 top-0 flex h-svh w-screen items-center justify-center"
  >
    <LoaderIcon class="animate-spin" size={64} />
  </div>
{:then file}
  <embed class="absolute left-0 top-0 h-svh w-screen" src={file} />
{/await}
