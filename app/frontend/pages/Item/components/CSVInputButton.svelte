<script lang="ts">
  import { parse } from 'csv-parse/browser/esm'
  import { Table } from 'lucide-svelte'

  import importCSVItems from '../utils/importCSVItems'

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
          try {
            if (err) throw err
            importCSVItems(data)
          } catch (error) {
            // TODO: show toast
            console.log(error, err)
          }
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
/>
