<script lang="ts">
  import dayjs from 'dayjs'

  import { formatIDR } from '$lib/utils'
  import type { Item } from '$types/typelizer'

  let { invoice } = $props()

  const grandTotal = invoice.items.reduce(
    (acc: number, item: Item) => acc + item.selling_price * item.quantity,
    0
  )

  $effect(() => {
    window.print()
  })
</script>

<main
  class="mt-8 flex h-[528px] w-[912px] flex-col border border-dashed border-red-400 px-[48px] text-sm print:border-0"
>
  <div
    class="flex grow flex-col border-x border-dashed border-red-400 bg-white p-4 print:border-x-0"
  >
    <div>Mustika Bumi Saga</div>
    <div>Jalan Saga, Bunar, Balaraja. Hp. 08211181289</div>
    <div class="mb-2 flex justify-center border-b border-black text-lg">
      INVOICE
    </div>
    <div class="mb-1">KEPADA Yth:</div>
    <div class="mb-4 flex justify-between gap-4 ps-4">
      <div class="w-full border-e border-black pe-4">
        <div class="mb-1 underline">
          {invoice.customer ? invoice.customer.name : ''}
        </div>
        <div>{invoice.address}</div>
      </div>
      <div class="flex w-[410px] flex-col">
        <div class="mb-1 flex justify-between">
          <div>Kode Invoice:</div>
          <div>{invoice.code}</div>
        </div>
        <div class="flex justify-between">
          <div>Tanggal:</div>
          <div>{dayjs(invoice.date).format('DD MMMM YYYY')}</div>
        </div>
      </div>
    </div>
    <div class="grow">
      <table class="w-full table-fixed border-collapse border border-black">
        <thead>
          <tr>
            <th class="border border-black">Nama Barang</th>
            <th class="w-[60px] border border-black ps-1">Jumlah</th>
            <th class="w-[60px] border border-black">Satuan</th>
            <th class="w-28 border border-black">Harga Satuan</th>
            <th class="w-32 border border-black">Total</th>
          </tr>
        </thead>
        <tbody>
          {#each invoice.items as item (item.id)}
            <tr>
              <td class="border border-black ps-1">{item.name}</td>
              <td class="border border-black ps-1">{item.quantity}</td>
              <td class="border border-black ps-1">{item.quantity_unit}</td>
              <td class="border border-black ps-1"
                >{formatIDR(item.selling_price)}</td
              >
              <td class="border border-black ps-1"
                >{formatIDR(item.selling_price * item.quantity)}</td
              >
            </tr>
          {/each}
          <tr
            ><td class="border border-black text-center font-bold" colspan="4"
              >TOTAL</td
            >
            <td class="border border-black ps-1 font-bold"
              >{formatIDR(grandTotal)}</td
            >
          </tr>
        </tbody>
      </table>
    </div>
    <div class="mt-4 flex justify-start">
      <div class="flex h-16 w-32 flex-col items-center border-b border-black">
        <div>Hormat Kami</div>
      </div>
    </div>
  </div>
</main>
