class IngredientsController < ApplicationController

  get '/ingredients/new' do
    if logged_in?
      @current_user_recipes = current_user.recipes
      erb :'ingredients/new'
    else
      redirect to '/login'
    end
  end

  post '/ingredients' do
    if params[:name] == "" || params[:recipe_id] == ""
      redirect to "/ingredients/new"
    else
      @ingredient = Ingredient.new(name: params[:name])
      @ingredient.recipe = Recipe.find_by_id(params[:recipe_id])
      @ingredient.save
      redirect to "/ingredients/#{@ingredient.id}"
    end
  end

  get '/ingredients/:id' do
    if logged_in?
      @ingredient = Ingredient.find_by_id(params[:id])
      @recipe = @ingredient.recipe
      erb :'ingredients/show'
    else
      redirect to '/login'
    end
  end

  get '/ingredients' do
    if logged_in?
      @ingredients = Ingredient.all
      erb :'ingredients/index'
    else
      redirect to '/login'
    end
  end

  get '/ingredients/:id/edit' do
    if logged_in?
      @ingredient = Ingredient.find_by_id(params[:id])
      if @ingredient.recipe.user.id == current_user.id
       erb :'ingredients/edit'
      else
        redirect to '/ingredients'
      end
    else
      redirect to '/login'
    end
  end

  patch '/ingredients/:id' do
    if params[:name] == "" || params[:recipe_id] == ""
      redirect to "/ingredients/#{params[:id]}/edit"
    else
      puts "Params: " + params.to_s
      @ingredient = Ingredient.find_by_id(params[:id])
      @ingredient.name = params[:name]
      @ingredient.recipe = Recipe.find_by_id(params[:recipe_id])
      @ingredient.save
      redirect to "/ingredients/#{@ingredient.id}"
    end
  end

  delete '/ingredients/:id/delete' do
    if logged_in?
      @ingredient = Ingredient.find_by_id(params[:id])
      if @ingredient.recipe.user.id == current_user.id
        @ingredient.delete
        redirect to '/ingredients'
      else
        redirect to '/ingredients'
      end
    else
      redirect to '/login'
    end
  end

end
