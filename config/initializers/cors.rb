# Allowed origins come from the environment so a redeploy is configuration rather
# than a code change. CORS_ORIGINS is a comma-separated list; the default covers
# the Vue dev server.
allowed_origins = ENV.fetch('CORS_ORIGINS', 'http://localhost:8080')
                     .split(',')
                     .map(&:strip)
                     .reject(&:empty?)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*allowed_origins)
    resource '*',
             headers: :any,
             methods: [:get, :post, :patch, :put, :delete, :options, :head],
             credentials: true
  end
end
