if defined? Rack::Cors
  Rails.configuration.middleware.insert_before 0, Rack::Cors do
    allow do
        origins Rails.application.secrets.host
        resource '/assets/*'
    end
  end
end