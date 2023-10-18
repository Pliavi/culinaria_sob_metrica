import Factory from '@ioc:Adonis/Lucid/Factory'
import User from 'App/Models/User'

export default Factory.define(User, ({ faker }) => {
  return User.create({
    email: faker.internet.email(),
    password: faker.internet.password(),
    name: faker.person.fullName(),
  })
}).build()
