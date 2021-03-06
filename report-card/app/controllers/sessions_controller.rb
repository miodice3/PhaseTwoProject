class SessionsController < ApplicationController

    def length_validation
        if !(params[:user][:first_name].length > 4 && params[:user][:username].length > 4 && params[:user][:password].length > 4)
            redirect to "/signuperror"
        end
    end

    get '/signup' do
        if session[:user_id]
            erb :'sessions/signup'
        else
            erb :'sessions/signup'
        end
    end

    post '/signup' do
        length_validation

        if !User.find_by(username: params[:user][:username])
            @user = User.create(params[:user])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            redirect to "/signuperror"
        end
    end

    get '/signuperror' do
        erb :'sessions/signuperror'
    end

    get '/login' do
        erb :'sessions/login'
    end

    post '/login' do
#        if User.all.find_by(username: params[:username]) #duplicate searching, nil value will no longer crash code.
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            erb :'sessions/login'
        end
#        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end