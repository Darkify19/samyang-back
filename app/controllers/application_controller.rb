class ApplicationController < ActionController::API
  before_action :set_csrf_token, unless: -> { request.format.json? }

  include SessionsHelper

  private

  def set_csrf_token
    # Only set CSRF token for non-API (HTML) requests
    if request.format.html?
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end
end
