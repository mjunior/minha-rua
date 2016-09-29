class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    logger.debug response
    '/complaints/' # Or :prefix_to_your_route
  end
end