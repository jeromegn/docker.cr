@[Link("ssl")]
lib LibSSL
  fun ssl_ctx_load_verify_locations = SSL_CTX_load_verify_locations(ctx: SSLContext, ca_file: UInt8*, ca_path: UInt8*) : Int32
  fun ssl_ctx_use_certificate_file = SSL_CTX_use_certificate_file(ctx: SSLContext, file: UInt8*, type: Int32) : Int32
  fun ssl_ctx_ctrl = SSL_CTX_ctrl(ctx: SSLContext, cmd: Int32, larg: UInt64, parg: Void*) : UInt64
  fun ssl_ctx_set_default_verify_paths = SSL_CTX_set_default_verify_paths(ctx: SSLContext) : Int32
  fun ssl_ctx_check_private_key = SSL_CTX_check_private_key(ctx: SSLContext) : Int32

  fun tlsv1_method = TLSv1_method : SSLMethod
end