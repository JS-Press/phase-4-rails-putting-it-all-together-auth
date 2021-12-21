class RecipesController < ApplicationController

    def index 
        user = User.find_by(id: session[:user_id])  
        if user 
         
            recipes = Recipe.all
            render json: recipes, include: :user, status: :created
        else
            render json: { errors: [1,2] }, status: :unauthorized
        end
    end

    def create 
        user = User.find_by(id: session[:user_id])  
        if user
            new_recipe = Recipe.new( rec_params )
            new_recipe.user_id = user.id
            if new_recipe.save
                render json: new_recipe, status: :created
            else
                render json: { errors: new_recipe.errors.full_messages }, status: :unprocessable_entity
            end
        else 
            render json: { errors: ["must login"] }, status: :unauthorized
        end
    end

    private 

    def rec_params
        params.permit( :title, :instructions, :minutes_to_complete )
    end

    # def rec_summmary 

    # end

end
