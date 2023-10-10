declare module '@ioc:CSM/Services' {
  import AttachmentService from 'App/Services/AttachmentService'

  const AttachmentServiceSingleton: AttachmentService

  export { AttachmentServiceSingleton as AttachmentService }
}
