import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, HasMany, belongsTo, column, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Place from './Place'
import Review from './Review'

export default class Food extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public name: string

  @column()
  public price: string

  @column()
  public image: string

  @hasMany(() => Review)
  public reviews: HasMany<typeof Review>

  @column({ serializeAs: null })
  public placeId: number

  @belongsTo(() => Place)
  public place: BelongsTo<typeof Place>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
