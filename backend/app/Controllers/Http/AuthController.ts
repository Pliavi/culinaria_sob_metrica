import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import User from 'App/Models/User'

export default class AuthController {
  public async validateToken({ auth }: HttpContextContract) {
    await auth.use('api').authenticate()

    return { success: true }
  }

  public async login({ auth, request }: HttpContextContract) {
    const email = request.input('email')
    const password = request.input('password')

    const token = await auth.use('api').attempt(email, password)

    return token
  }

  public async register({ request, response }: HttpContextContract) {
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
      name: email.split('@')[0],
    })

    return response.created({ success: true })
  }
}
