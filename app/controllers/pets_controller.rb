class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :"/pets/index"
  end

  get '/pets/new' do 
    @owners = Owner.all
    # can visit '/pets/new'
    erb :"/pets/new"
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet .save
      # Create new pet an a new owner
    else
      @pet.owner = Owner.find(params[:pet][:owner_id])
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    # @pet = Pet.find.keys.include?(id)
    erb :"/pets/show"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end

    redirect "pets/#{@pet.id}"
  end
end