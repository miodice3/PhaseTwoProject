class GoalsController < ApplicationController
    
    #current user helper method
    #method that checks the current user exists (logged in) and redirect if user is not logged in

    def current_user
        @user = User.find_by_id(session[:user_id])
    end

    def redirect_if_not_logged_in
        if !current_user
            redirect to "/error"
        end
    end

    def is_authorized
        @goal = Goal.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        if @user.id != @goal.user_id
            redirect to "/error"
        end
    end

    # def is_authorized
    #     if current_user.goals.find_by_id(params[:id])
    #         redirect to "/error"
    #     end
    # end

    get '/goals/new' do
        erb :'goals/new'
    end

    get '/goals/mygoals' do
        @user=User.all.find_by_id(session[:user_id])
        @goals = @user.goals
        erb :'goals/mygoals'
    end

    post '/goals' do
        @goal = Goal.create(params[:goal])  #creation with session ID, user can only input fields that become their own goals.
        @goal.user_id=session[:user_id]
        @goal.save
        redirect "/goals/#{@goal.id}"
    end

    get '/goals/:id' do 
        is_authorized
        erb :'goals/show'
    end

    get '/goals/:id/edit' do
        is_authorized
        erb :'goals/edit'
    end

    patch '/goals/:id' do
        is_authorized
        @goal.update(params[:update])
        @goal.save
        redirect "/goals/#{@goal.id}"
    end

    delete '/goals/:id' do
        is_authorized
        @goal.destroy
        redirect "/goals/mygoals"
    end

end