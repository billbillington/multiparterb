module MultipartErb
  class Railtie < ::Rails::Railtie
    config.app_generators.mailer :template_engine => :multipart
  end
end
