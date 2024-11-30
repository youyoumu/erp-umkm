import { w } from '$lib/utils'
import type { ItemForm } from '$types/formTypes'

// prettier-ignore
type ItemCSV = {
  "Nama Barang*": string;
  "Harga Modal": string;
  "Harga Jual*": string;
  "Stok": string;
  "Satuan*": string;
  "Kode Barang": string;
  "Kategori": string;
  "Tag": string;
  "Catatan": string;
}

export default async function importCSVItems(data: ItemCSV[]) {
  for (const item of data) {
    const itemForm: ItemForm = {
      name: item['Nama Barang*'],
      cost_price: parseFloat(item['Harga Modal']),
      selling_price: parseFloat(item['Harga Jual*']),
      stock: item['Stok'],
      quantity_unit: item['Satuan*'],
      code: item['Kode Barang'],
      category: item['Kategori'],
      tag: item['Tag'],
      notes: item['Catatan'],
    }

    await w.url('/items').post({ item: itemForm }).res()
  }
}
