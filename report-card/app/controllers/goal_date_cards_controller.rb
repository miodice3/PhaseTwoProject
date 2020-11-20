class GoalDateCardsController < ApplicationController


    before do
        if !session[:user_id]
            halt 401, 'you do not have access to this page while not logged in. Return to the sign in page to continue.'
        end
        # pass if request.path_info == "/login" || request.path_info == "/signup"
        #or error
    end

    get '/gdcs' do
        binding.pry
        @gdcs = GoalDateCard.all
        erb :'gdcs/index'
    end

    get '/gdcs/auto' do
        binding.pry
    end

    post '/gdcs/autocreate/:id' do
        binding.pry
    end

    get '/gdcs/new' do
        binding.pry
#        @user = User.all.find_by_id(session[:user_id])
        erb :'gdcs/new'
    end

    post '/gdcs' do
       #binding.pry
       #validate it here to make sure edits are still coming in for owners cards & dates, if both pass, allowcreation.
       #tis works to create record from clicking, need to remove inputs and send id's as slugs
       # binding.pry
            if @gdc=GoalDateCard.find_by(goal_id: params[:gdc][:goal_id].to_i, date_card_id: params[:gdc][:date_card_id].to_i)
                @gdc.update(params[:gdc])
                @gdc.save
            else
                #binding.pry
                @gdc = GoalDateCard.create(params[:gdc])
            end
        redirect "/gdcs/#{@gdc.id}"
    end

    get '/gdcs/:id/edit' do
        binding.pry
#        @user = User.find_by_id(params[:id])
        @gdc = GoalDateCard.find_by_id(params[:id])
        erb :'gdcs/edit'
    end

    get '/gdcs/:id' do
        @gdc = GoalDateCard.find_by_id(params[:id])
        #@user = User.find_by_id(session[:user_id])
        #binding.pry
        erb :'gdcs/show'
    end

    patch '/gdcs/:id' do
        binding.pry
        #currently any user can edit any goal
        gdc = GoalDateCard.find_by_id(params[:id])
        gdc.update(params[:update])
        gdc.save
        redirect "/gdcs/#{gdc.id}"
    end

    delete '/gdcs/:id' do
        gdc = GoalDateCard.find_by_id(params[:id])
        gdc.destroy
        redirect "/gdcs"
    end

end