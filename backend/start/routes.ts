/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import Hash from '@ioc:Adonis/Core/Hash'
import Route from '@ioc:Adonis/Core/Route'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import Drive from '@ioc:Adonis/Core/Drive'
import crypto from 'crypto'

import User from 'App/Models/User'
import Application from '@ioc:Adonis/Core/Application'

Route.post('photo', async ({ request, response }) => {
  const photo = request.file('photo')

  const fileName = await photo!.move(Application.tmpPath('uploads'))
})

Route.get('photod', async ({}) => {
  return await Drive.delete('quarto.png')
})

Route.get('/', async () => {
  return { hello: 'world' }
})

Route.post('login', async ({ auth, request, response }) => {
  const email = request.input('email')
  const password = request.input('password')

  try {
    const token = await auth.use('api').attempt(email, password)
    return token
  } catch {
    return response.unauthorized('Invalid credentials')
  }
})

Route.post('register', async ({ request, response }) => {
  const email = request.input('email')
  const password = request.input('password')

  const registerSchema = schema.create({
    email: schema.string({ trim: true }, [
      rules.email(),
      rules.unique({ table: 'users', column: 'email' }),
    ]),
    password: schema.string({}, [rules.confirmed()]),
  })

  await request.validate({ schema: registerSchema })

  await User.create({
    email: email,
    password: password,
  })

  return response.created({ success: true })
})

Route.get('/google/redirect', async ({ ally }) => {
  return ally.use('google').redirect()
})

Route.get('/google/callback', async ({ ally, auth, response }) => {
  const google = ally.use('google')

  try {
    const googleUser = await google.user()

    const user = await User.firstOrCreate(
      { email: googleUser.email! },
      {
        id: crypto.randomUUID(),
        password: await Hash.make(googleUser.id),
      }
    )

    const token = await auth.use('api').login(user)

    return response.redirect().toPath('/?token=' + token.toJSON().token)
  } catch (error) {
    return 'Unable to authenticate. Try again later' + error.message
  }
})

Route.get('htmlGoogle', async () => {
  return `
    <html>
      <head>
        <title>Google Login</title>
      </head>
      <body>
        <a href="/google/redirect">Login with Google</a>
      </body>
    </html>
  `
})

Route.resource('foods', 'UserFoodsController').apiOnly()
