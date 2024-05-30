Rails.application.config.middleware.insert_before 0, Rack::Cors do
 
  allow do
    origins 'http://localhost:5173' # Update with your frontend URL
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Authorization],
             credentials: true
  end
end
