import BaseSchema from '@ioc:Adonis/Lucid/Schema'

export default class extends BaseSchema {
  protected tableName = 'reviews'

  public async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id').primary()

      table.string('title', 255).nullable()
      table.text('comment').nullable()
      table.double('rating').checkBetween([0, 5], 'rating_range').notNullable()
      table.integer('likes').defaultTo(0).notNullable()

      table.integer('user_id').references('id').inTable('users').onDelete('CASCADE')
      table.integer('food_id').references('id').inTable('foods').onDelete('CASCADE')

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
