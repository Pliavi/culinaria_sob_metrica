import food from 'App/Models/Food'
import Factory from '@ioc:Adonis/Lucid/Factory'
import Food from 'App/Models/Food'

export default Factory.define(food, ({ faker }) => {
  return Food.create({
    name: faker.lorem.words(2),
    price: faker.finance.amount(1, 100, 2),
    // image: faker.image.urlLoremFlickr({
    //   width: 640,
    //   height: 480,
    //   category: 'food',
    // }),
  })
}).build()
