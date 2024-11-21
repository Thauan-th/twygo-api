# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  private

  def error_wrapper(errors)
    {
      errors: errors,
      error: true
    }
  end
end
