export type Invoice = {
  id: number
  date: string
  code: string
  address: string
  customer: Customer
  items: Item[]
}

export type Customer = {
  id: number
  name: string
  notes: string
  address: string
  contact: string
}

export type Item = {
  id: number
  name: string
  notes: string
  cost_price: number
  selling_price: number
  stock: number
  code: string
  category: string
  quantity: number
  quantity_unit: string
  tag: string
}

export type ItemWithLabelValue = Item & { label: string; value: number }
export type InvoiceWithItemLabelValue = Modify<
  Invoice,
  { items: ItemWithLabelValue[] }
>

type Modify<T, R> = Omit<T, keyof R> & R
