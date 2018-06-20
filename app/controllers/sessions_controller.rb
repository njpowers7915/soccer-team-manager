require 'pry'

class SessionsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

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
