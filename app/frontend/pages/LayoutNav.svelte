<script>
import { inertia, router } from "@inertiajs/svelte"
import NavLink from "./NavLink.svelte"
let page = window.location.pathname
window.addEventListener("popstate", () => {
  page = window.location.pathname
})
router.on("success", (event) => {
  page = event.detail.page.url
})
</script>

<main class="container h-svh">
  <header class="flex justify-between bg-slate-900 px-4 py-4 text-white">
    <div>
      <NavLink href="/dashboard" active={page.startsWith("/dashboard/") || page === "/dashboard"}>Dashboard</NavLink>
    </div>
    <div>
      <NavLink href="/items" active={page.startsWith("/items/") || page === "/items"}>Items</NavLink>
      <NavLink href="/customers" active={page.startsWith("/customers/") || page === "/customers"}>Customers</NavLink>
      <NavLink href="/invoices" active={page.startsWith("/invoices/") || page === "/invoices"}>Invoices</NavLink>
    </div>
  </header>
  <slot />
</main>
