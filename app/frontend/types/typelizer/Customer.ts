// Typelizer digest a473b910b8062e2b3206cfc090010a46
//
// DO NOT MODIFY: This file was automatically generated by Typelizer.
import type {Invoice} from '$types/typelizer'

type Customer = {
  id: number;
  name: string | null;
  notes: string | null;
  address: string | null;
  contact: string | null;
  invoices: Array<Invoice>;
}

export type { Customer };
