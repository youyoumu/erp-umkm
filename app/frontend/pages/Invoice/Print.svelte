<script>
import Invoice from "./Invoice.svelte"
import { formatIDR } from "$lib/utils"
import dayjs from "dayjs"

export let invoice
export let items
export let customer
</script>

<main class="flex h-[528px] w-[816px] flex-col border p-4 text-xs font-medium">
  <div>Mustika Bumi Saga</div>
  <div>Jalan Saga, Bunar, Balaraja. Hp. 08211181289</div>
  <div class="mb-2 flex justify-center border-b border-black text-lg">NOTA</div>
  <div class="mb-1">KEPADA Yth:</div>
  <div class="mb-4 flex justify-between gap-4 ps-4">
    <div class="h-12 w-full">
      <div class="mb-1">{customer ? customer.name : ""}</div>
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
  <div class="grow border"></div>
  <div class="mt-4 flex justify-start">
    <div class="flex h-16 w-32 flex-col items-center border-b border-black">
      <div>Hormat Kami</div>
    </div>
  </div>
</main>
