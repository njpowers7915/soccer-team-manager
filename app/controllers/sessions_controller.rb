class SessionsController < ApplicationController

    get '/signup' do
        #erb :'/teams/signup'
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :'/teams/signup'
        else
            redirect "teams/#{@team.slug}"
        end
    end

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

    get '/login' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :'teams/login'
        else
            redirect "teams/#{@team.slug}"
        end
    end

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

    get '/logout' do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end

end
