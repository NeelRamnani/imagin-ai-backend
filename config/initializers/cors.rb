Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # later change to the domain of the frontend app
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], credentials: true
  end
end
