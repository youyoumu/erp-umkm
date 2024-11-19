export type ItemForm = {
  name: string
  notes: string
  cost_price: string | number
  selling_price: string | number
  stock: string
  code: string
  category: string
  tag: string
  quantity_unit: string
}

export type CustomerForm = {
  name: string
  notes: string
  address: string
  contact: string
}

export type InvoiceForm = {
  date: string
  code: string
  address: string
  customer: {
    id: number
  }
  items: {
    id: number
    quantity: number
    quantity_unit: string
    selling_price: number
  }[]
}
