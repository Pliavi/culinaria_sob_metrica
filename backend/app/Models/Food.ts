import { DateTime } from 'luxon'
import {
  BaseModel,
  BelongsTo,
  HasMany,
  beforeSave,
  belongsTo,
  column,
  hasMany,
} from '@ioc:Adonis/Lucid/Orm'
import Place from './Place'
import Review from './Review'
import Photo from './Photo'
import User from './User'
import crypto from 'crypto'
export default class Food extends BaseModel {
  @column({ isPrimary: true })
  public id: string

  @column()
  public name: string

  @column()
  public price: string

  @column({ serializeAs: null })
  public userId: string
  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @column({ serializeAs: null })
  public photoId: string
  @belongsTo(() => Photo)
  public photo: BelongsTo<typeof Photo>

  @column({ serializeAs: null })
  public placeId: string
  @belongsTo(() => Place)
  public place: BelongsTo<typeof Place>

  @hasMany(() => Review)
  public reviews: HasMany<typeof Review>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @beforeSave()
  public static setUUID(food: Food) {
    food.id = crypto.randomUUID()
  }
}
