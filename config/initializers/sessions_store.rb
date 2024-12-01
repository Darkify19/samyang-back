Rails.application.config.session_store :cookie_store, key: '_test_backend_session', secure: Rails.env.production?
