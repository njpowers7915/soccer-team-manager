class SessionsController < ApplicationController

#Signup route
    get '/signup' do
        #erb :'/teams/signup'
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :'/teams/signup'
        else
            redirect "teams/#{@team.slug}"
        end
    end

#Signup form that leads to user logging in
    post '/signup' do
        @team = Team.new(:name => params[:name], :username => params[:username], :password => params[:password])
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
          redirect '/signup'
        else
          @team.save
          session[:team_id] = @team.id
          session[:last_visited] = @team.id
          redirect "teams/#{@team.slug}"
        end
    end

#Login route
    get '/login' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :'teams/login'
        else
            redirect "teams/#{@team.slug}"
        end
    end

#Login form
    post '/login' do
        @team = Team.find_by(:username => params[:username])
        if @team && @team.authenticate(params[:password])
            session[:team_id] = @team.id
            session[:last_visited] = @team.id
            redirect "teams/#{@team.slug}"
        else
            redirect '/login'
        end
    end

#Logout Route
    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end

end
