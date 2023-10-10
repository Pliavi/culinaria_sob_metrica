import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'foods'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()

      table.string('name', 255).notNullable()
      table.string('price', 255).nullable()
      table.string('mean_rating', 3).nullable() // This is the mean rating of all reviews ratings of this food

      table.integer('place_id').references('id').inTable('places').onDelete('CASCADE')
      table.integer('user_id').references('id').inTable('users').onDelete('SET NULL')
      table.integer('photo_id').references('id').inTable('photos').onDelete('SET NULL')

      /**
       * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
       */
      table.timestamp('created_at', { useTz: true })
      table.timestamp('updated_at', { useTz: true })
    })
  }

  public async down() {
    this.schema.dropTable(this.tableName)
  }
}
