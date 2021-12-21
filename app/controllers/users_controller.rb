class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    
    user = User.new(user_params)
    
    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end


  def show 
    user = User.find( session[:user_id] )
    if user
      render json: user, status: :created
    else 
      render json: { errors: user.errors.full_messages }, status: :unauthorized
    end
  end

private 

def user_params 
  params.permit( :username, :image_url, :bio, :password, :password_confirmation )
end

def render_not_found_response 
  render json: { errors: 'not_found' }, status: :unauthorized
end


end
