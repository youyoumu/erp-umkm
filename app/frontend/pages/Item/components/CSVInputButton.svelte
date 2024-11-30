<script lang="ts">
  import { Table } from 'lucide-svelte'
</script>

<label
  for="import-csv"
  class="bg-secondary text-secondary-foreground text-sm px-4 flex items-center rounded-md hover:bg-secondary/80 cursor-pointer gap-1.5 font-medium transition-colors"
>
  <Table size="20" />
  Import CSV
</label>
<input type="file" id="import-csv" accept=".csv" class="hidden" />
