import Factory from '@ioc:Adonis/Lucid/Factory'
import Food from 'App/Models/Food'

export default Factory.define(Food, ({ faker }) => {
  return Food.create({
    name: faker.lorem.words(2),
    price: faker.finance.amount(1, 100, 2),
  })
}).build()
