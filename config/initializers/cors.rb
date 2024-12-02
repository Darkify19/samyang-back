# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://samyang-front-g7jeey08v-darkifys-projects.vercel.app/'  # Your frontend URL
    resource '*',
             headers: :any,
             methods: [:get, :post, :patch, :put, :delete, :options, :head],
             credentials: true
  end
end
