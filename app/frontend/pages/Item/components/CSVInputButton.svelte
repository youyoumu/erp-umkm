<script lang="ts">
  import { router } from '@inertiajs/svelte'
  import { parse } from 'csv-parse/browser/esm'
  import { Table } from 'lucide-svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js'

  import importCSVItems from '../utils/importCSVItems'

  let alertState = $state({
    title: '',
    description: '',
    open: false,
    onlyConfirm: false,
  })
  let csvData = $state<Record<string, string>[]>([])
  let fileInput: HTMLInputElement

  function handleFileInput(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0]
    if (!file) return
    const reader = new FileReader()
    reader.readAsText(file)
    reader.onload = (e) => {
      const csv = e.target?.result as string
      parse(
        csv,
        {
          columns: true,
          skip_empty_lines: true,
          from_line: 2,
        },
        (err, data) => {
          if (err) {
            alertState.title = 'Tidak dapat membaca CSV'
            alertState.description = err.message.slice(0, 100)
            alertState.open = true
            alertState.onlyConfirm = true
            return
          }

          alertState.title = 'Import CSV?'
          alertState.description = ''
          alertState.open = true
          alertState.onlyConfirm = false

          csvData = data
        }
      )
    }
  }
</script>

<label
  for="import-csv"
  class="bg-secondary text-secondary-foreground text-sm px-4 flex items-center rounded-md hover:bg-secondary/80 cursor-pointer gap-1.5 font-medium transition-colors"
>
  <Table size="20" />
  Import CSV
</label>
<input
  type="file"
  id="import-csv"
  accept=".csv"
  class="hidden"
  onchange={handleFileInput}
  bind:this={fileInput}
/>
<AlertDialog.Root
  open={alertState.open}
  onOpenChange={(open) => {
    alertState.open = open
    if (!open) csvData = []
    fileInput.value = ''
  }}
>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>{alertState.title}</AlertDialog.Title>
      <AlertDialog.Description>
        <div>{alertState.description}</div>
        <div class="flex flex-col gap-2">
          {#each csvData.slice(0, 3) as row}
            <div>
              {#each Object.entries(row) as [key, value]}
                {key}: {value},{' '}
              {/each}
            </div>
          {/each}
        </div>
      </AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      {#if alertState.onlyConfirm}
        <AlertDialog.Cancel class="bg-primary text-primary-foreground">
          Ok
        </AlertDialog.Cancel>
      {:else}
        <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
        <AlertDialog.Action
          onclick={async () => {
            try {
              alertState.onlyConfirm = false
              // @ts-expect-error the template might be wrong
              await importCSVItems(csvData)
              alertState.title = 'Import selesai'
              alertState.onlyConfirm = true
              alertState.open = true

              csvData = []
              router.reload({
                only: ['items'],
              })
            } catch (error) {
              console.error(error)
              alertState.title = 'Import bermasalah'
              alertState.open = true
              alertState.onlyConfirm = true
            }
          }}>Import</AlertDialog.Action
        >
      {/if}
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
