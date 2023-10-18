import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, HasMany, belongsTo, column, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Food from './Food'
import Photo from './Photo'
import User from './User'

export default class Place extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column()
  public name: string

  @column()
  public description: string

  @column()
  public address: string

  @column()
  public city: string

  @column()
  public state: string

  @column()
  public country: string

  @column()
  public zipCode: string

  @column()
  public phone: string

  @column()
  public website: string

  @column({ serializeAs: null })
  public photoId: string
  @belongsTo(() => Photo)
  public photo: BelongsTo<typeof Photo>

  @column({ serializeAs: null })
  public userId: number
  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @hasMany(() => Food)
  public foods: HasMany<typeof Food>

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
