import { TransactionClientContract } from '@ioc:Adonis/Lucid/Database'

export type RepoCreateOptions = {
  trx: TransactionClientContract
}
