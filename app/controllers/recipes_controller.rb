class RecipesController < ApplicationController

  get '/recipes/new' do
    if logged_in?
      erb :'recipes/create_recipe'
    else
      redirect to '/login'
    end
  end

  post '/recipes' do
    if params[:content] == ""
      redirect to "/recipes/new"
    else
      @recipe = current_user.recipes.create(content: params[:content])
      redirect to "/recipes/#{@recipe.id}"
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      @ingredients = @recipe.ingredients
      erb :'recipes/show_recipe'
    else
      redirect to '/login'
    end
  end

  get '/recipes' do
    if logged_in?
      @recipes = Recipe.all
      erb :'recipes/recipes'
    else
      redirect to '/login'
    end
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find_by_id(params[:id])
      if @recipe.user_id == current_user.id
       erb :'recipes/edit_recipe'
      else
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end

  patch '/recipes/:id' do
    if params[:content] == ""
      redirect to "/recipes/#{params[:id]}/edit"
    else
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.content = params[:content]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
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
