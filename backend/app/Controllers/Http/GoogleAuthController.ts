import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import User from 'App/Models/User'
import crypto from 'crypto'

export default class GoogleAuthController {
  public callGoogleAuth({ ally }: HttpContextContract) {
    return ally.use('google').redirect()
  }

  public async googleCallback({ ally, auth }: HttpContextContract) {
    const google = ally.use('google')

    const googleUser = await google.user()

    const user = await User.firstOrCreate(
      { email: googleUser.email! },
      {
        name: googleUser.name,
        email: googleUser.email!,
        password: crypto.randomBytes(10).toString('hex'),
      }
    )

    const token = await auth.use('api').login(user)

    return token.toJSON()
  }
}
