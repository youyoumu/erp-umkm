<script>
import { formatIDR } from "$lib/utils"
import dayjs from "dayjs"
import { onMount } from "svelte"

export let invoice
export let items // max 11 items
export let customer

const grandTotal = items.reduce((acc, item) => acc + item.selling_price * item.quantity, 0)

onMount(() => {
  window.print()
})
</script>

<main class="flex h-[528px] w-[912px] flex-col border border-dashed border-red-400 px-[48px] text-xs font-medium print:border-0">
  <div class="flex grow flex-col border-x border-dashed border-red-400 bg-white p-4 print:border-x-0">
    <div>Mustika Bumi Saga</div>
    <div>Jalan Saga, Bunar, Balaraja. Hp. 08211181289</div>
    <div class="mb-2 flex justify-center border-b border-black text-lg">NOTA</div>
    <div class="mb-1">KEPADA Yth:</div>
    <div class="mb-4 flex justify-between gap-4 ps-4">
      <div class="h-12 w-full border-r border-black pe-4">
        <div class="mb-1 underline">{customer ? customer.name : ""}</div>
        <div>{invoice.address}</div>
      </div>
      <div class="flex flex-col">
        <div class="mb-1 flex justify-between">
          <div>Kode Nota:</div>
          <div>{invoice.code}</div>
        </div>
        <div class="flex w-56 justify-between">
          <div>Tanggal:</div>
          <div>{dayjs(invoice.date).format("DD MMMM YYYY")}</div>
        </div>
      </div>
    </div>
    <div class="grow">
      <table class="w-full table-fixed border-collapse border border-black">
        <tr>
          <th class="border border-black">Nama Barang</th>
          <th class="w-14 border border-black">Jumlah</th>
          <th class="w-[52px] border border-black">Satuan</th>
          <th class="w-24 border border-black">Harga Satuan</th>
          <th class="w-28 border border-black">Total</th>
        </tr>
        {#each items as item (item.id)}
          <tr>
            <td class="border border-black ps-1">{item.name}</td>
            <td class="border border-black ps-1">{item.quantity}</td>
            <td class="border border-black ps-1">{item.quantity_unit}</td>
            <td class="border border-black ps-1">{formatIDR(item.selling_price)}</td>
            <td class="border border-black ps-1">{formatIDR(item.selling_price * item.quantity)}</td>
          </tr>
        {/each}
        <tr
          ><td class="border border-black text-center font-bold" colspan="4">TOTAL</td>
          <td class="border border-black ps-1 font-bold">{formatIDR(grandTotal)}</td>
        </tr>
      </table>
    </div>
    <div class="mt-4 flex justify-start">
      <div class="flex h-16 w-32 flex-col items-center border-b border-black">
        <div>Hormat Kami</div>
      </div>
    </div>
  </div>
</main>
