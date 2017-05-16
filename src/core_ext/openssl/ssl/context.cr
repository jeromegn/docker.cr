class OpenSSL::SSL::Context
  
  def ca_file=(file)
    if LibSSL.ssl_ctx_load_verify_locations(@handle, file, nil) == 0
      raise "unable to set CA file"
    end
  end

  def certificate_file=(file)
    if LibSSL.ssl_ctx_use_certificate_file(@handle, file, 1) == 0
      raise "unable to set certificate file"
    end
  end

  def check_private_key
    if LibSSL.ssl_ctx_check_private_key(self) == 0
      raise "check private key failed"
    end
  end

  def set_default_verify_paths
    LibSSL.ssl_ctx_set_default_verify_paths(self)
  end
end
