<script lang="ts">
  import { parse } from 'csv-parse/browser/esm'
  import { Table } from 'lucide-svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js'

  import importCSVItems from '../utils/importCSVItems'

  let isOpen = $state(false)
  let alertTitle = $state('')
  let alertDescription = $state('')
  let csvData = $state<Record<string, string>[]>([])
  let isShowOk = $state(false)

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
            alertTitle = 'Tidak dapat membaca CSV'
            alertDescription = err.message.slice(0, 100)
            isShowOk = true
            isOpen = true
            return
          }

          alertTitle = 'Import CSV?'
          alertDescription = ''
          csvData = data
          isShowOk = false
          isOpen = true
        }
      )
    }
  }

  $inspect(isOpen)
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
/>
<AlertDialog.Root
  open={isOpen}
  onOpenChange={(open) => {
    isOpen = open
    if (!open) csvData = []
  }}
>
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>{alertTitle}</AlertDialog.Title>
      <AlertDialog.Description>
        <div>{alertDescription}</div>
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
      {#if isShowOk}
        <AlertDialog.Cancel class="bg-primary text-primary-foreground">
          Ok
        </AlertDialog.Cancel>
      {:else}
        <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
        <AlertDialog.Action
          onclick={async () => {
            try {
              isOpen = false
              // @ts-expect-error the template might be wrong
              await importCSVItems(csvData)
              alertTitle = 'Import selesai'
              csvData = []
              isShowOk = true
              isOpen = true
            } catch (error) {
              console.log(error)
              isOpen = true
              alertTitle = 'Import bermasalah'
              isShowOk = true
            }
          }}>Import</AlertDialog.Action
        >
      {/if}
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
