import type { ApplicationContract } from '@ioc:Adonis/Core/Application'
import fs from 'fs'
import path from 'path'

/*
|--------------------------------------------------------------------------
| Provider
|--------------------------------------------------------------------------
|
| Your application is not ready when this file is loaded by the framework.
| Hence, the top level imports relying on the IoC container will not work.
| You must import them inside the life-cycle methods defined inside
| the provider class.
|
| @example:
|
| public async ready () {
|   const Database = this.app.container.resolveBinding('Adonis/Lucid/Database')
|   const Event = this.app.container.resolveBinding('Adonis/Core/Event')
|   Event.on('db:query', Database.prettyPrint)
| }
|
*/
export default class RepositoryProvider {
  constructor(protected app: ApplicationContract) {}

  public register() {
    const repositoriesDir = 'app/Repositories'
    const repoPath = path.join(__dirname, '..', repositoriesDir)
    const repositoryFiles = fs.readdirSync(repoPath)
    const repos = repositoryFiles.reduce((acc: Record<string, any>, file: string) => {
      if (file.endsWith('.ts')) {
        const repositoryName = path.basename(file, '.ts')
        const repositoryPath = `${repositoriesDir}/${repositoryName}`
        const repo = new (require(`../${repositoryPath}`).default)()
        acc[repositoryName] = repo
      }
      return acc
    }, {})
    this.app.container.singleton('CSM/Repositories', () => {
      return repos
    })
  }
  public async boot() {}

  public async ready() {
    // App is ready
  }

  public async shutdown() {
    // Cleanup, since app is going down
  }
}
