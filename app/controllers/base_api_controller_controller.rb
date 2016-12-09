class BaseApiControllerController < ApplicationController
  before_filter :allow_parameters, except: [:index]
  
  def validate_json(condition)
    unless condition
      render nothing: true, status: :bad_request
    end
  end
  
  def allow_parameters
    params.permit!
  end 
end
