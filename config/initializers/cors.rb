Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow frontend in development (localhost) and production (vercel) to access the backend
    origins 'http://localhost:8080', 'https://samyang-front.vercel.app'  # Your frontend URL(s)

    resource '*',
             headers: :any,
             methods: [:get, :post, :patch, :put, :delete, :options, :head],
             credentials: true
  end
end
