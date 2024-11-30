import { type ClassValue, clsx } from 'clsx'
import Cookies from 'js-cookie'
import { twMerge } from 'tailwind-merge'
import wretch from 'wretch'

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function formatIDR(amount: number | null) {
  if (amount === null) return ''
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(amount)
}

const w = wretch().headers({
  'X-CSRF-TOKEN': Cookies.get('XSRF-TOKEN') || '',
  'Content-Type': 'application/json',
  Accept: 'application/json',
})

export { w }
