export interface Invoice {
  id: number
  date: string
  code: string
  address: string
  customer: Customer
  items: Item[]
}

export interface Customer {
  id: number
  name: string
  notes: string
  address: string
  contact: string
}

export interface Item {
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
