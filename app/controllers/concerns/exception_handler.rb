module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity
  end

  private

  def handle_not_found(exception)
    json_response({ message: exception.message }, :not_found)
  end

  def handle_unprocessable_entity(exception)
    json_response({ message: exception.message }, :unprocessable_entity)
  end
end
