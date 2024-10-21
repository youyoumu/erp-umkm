<script lang="ts">
import { Link } from "@inertiajs/svelte"
import type { Customer, InvoiceWithItemLabel, ItemWithLabel } from "../../lib/types"
import Form from "./Form.svelte"

export let invoice: InvoiceWithItemLabel
export let items: ItemWithLabel[]
export let customers: Customer[]

const handleSubmit = (e) => {
  const { form } = e.detail
  form.transform((data) => ({ invoice: data }))
  form.patch(`/invoices/${invoice.id}`)
}
</script>

<svelte:head>
  <title>Editing invoice</title>
</svelte:head>

<div class="mx-auto w-full px-8 pt-8 md:w-2/3">
  <h1 class="text-4xl font-bold">Editing invoice</h1>

  <Form items={items} invoice={invoice} customers={customers} submitText="Update Nota" on:submit={handleSubmit} />

  <Link href={`/invoices/${invoice.id}`} class="mt-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium">Show this invoice</Link>
  <Link href="/invoices" class="ml-2 inline-block rounded-lg bg-gray-100 px-5 py-3 font-medium">Back to invoices</Link>
</div>
