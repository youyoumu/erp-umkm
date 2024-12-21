<script lang="ts">
  import { stringify } from 'csv-stringify/browser/esm'
  import dayjs from 'dayjs'
  import { saveAs } from 'file-saver'
  import { Table } from 'lucide-svelte'

  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js'
  import { Button } from '$lib/components/ui/button'
  import type { Item } from '$types/typelizer'

  let { items }: { items: Item[] } = $props()

  function onclick() {
    stringify(
      items,
      {
        header: true,
        columns: {
          name: 'Nama Barang*',
          cost_price: 'Harga Modal',
          selling_price: 'Harga Jual*',
          stock: 'Stok',
          quantity_unit: 'Satuan*',
          code: 'Kode Barang',
          category: 'Kategori',
          tag: 'Tag',
          notes: 'Catatan',
        },
      },
      (err, output) => {
        if (err) console.error(err)
        output = ',Template Penambahan Barang erp-umkm,,,,,,,\n' + output
        const blob = new Blob([output], { type: 'text/csv;charset=utf-8;' })
        const fileName = `Daftar-Barang-${dayjs().format('DD-MM-YYYY')}.csv`
        saveAs(blob, fileName)
      }
    )
  }
</script>

<AlertDialog.Root>
  <AlertDialog.Trigger
    ><Button variant="secondary">
      <Table size="20" />
      Export CSV</Button
    ></AlertDialog.Trigger
  >
  <AlertDialog.Content>
    <AlertDialog.Header>
      <AlertDialog.Title>Export CSV?</AlertDialog.Title>
      <AlertDialog.Description></AlertDialog.Description>
    </AlertDialog.Header>
    <AlertDialog.Footer>
      <AlertDialog.Cancel>Batal</AlertDialog.Cancel>
      <AlertDialog.Action {onclick}>Export</AlertDialog.Action>
    </AlertDialog.Footer>
  </AlertDialog.Content>
</AlertDialog.Root>
