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

export default function importCSVItems(data: ItemCSV[]) {
  console.log(data)
}
