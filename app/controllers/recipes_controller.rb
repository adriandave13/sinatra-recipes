class RecipesController < ApplicationController

  get '/recipes/new' do
    if logged_in?
      @recipe ||= Recipe.new
      erb :'recipes/new'
    else
      redirect to '/login'
    end
  end

  post '/recipes' do
    @recipe = current_user.recipes.new(name: params[:name], instructions: params[:instructions])
    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      erb :'/recipes/new'
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      @ingredients = @recipe.ingredients
      erb :'recipes/show'
    else
      redirect to '/login'
    end
  end

  get '/recipes' do
    if logged_in?
      @recipes = Recipe.all
      erb :'recipes/index'
    else
      redirect to '/login'
    end
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe.user_id == current_user.id
        erb :'recipes/edit'
      else
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.instructions = params[:instructions]
    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      erb :'/recipes/edit'
    end
  end

  delete '/recipes/:id/delete' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe.user_id == current_user.id
        @recipe.delete
        redirect to '/recipes'
      else
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end

end
