# File: spec/recipe_repository_spec.rb

require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  context 'all method' do
    it 'returns a list of recipes' do
      repo = RecipeRepository.new
      recipes = repo.all
      expect(recipes.length).to eq (2)
      expect(recipes[0].id).to eq '1'
      expect(recipes[0].name).to eq 'Spaghetti Bolognese'
      expect(recipes[0].cooking_time).to eq '20 minutes'
      expect(recipes[0].rating).to eq '3'
    end
    it 'returns a list of recipes' do 
      repo = RecipeRepository.new
      recipes = repo.all
      expect(recipes[1].id).to eq '2'
      expect(recipes[1].name).to eq 'Spaghetti Carbonara'
      expect(recipes[1].cooking_time).to eq '15 minutes'
      expect(recipes[1].rating).to eq '4'
    end
  end
  context 'find method' do
    it 'finds a recipe by id' do
      repo = RecipeRepository.new
      recipe = repo.find(1)
      expect(recipe.id).to eq '1'
      expect(recipe.name).to eq 'Spaghetti Bolognese'
      expect(recipe.cooking_time).to eq '20 minutes'
      expect(recipe.rating).to eq '3'
    end
  end
end
