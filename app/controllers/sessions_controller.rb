class SessionsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

    get '/signup' do
        erb :'/teams/signup'
        #@user = Helpers.current_user(session)
        #if Helpers.is_logged_in?(session) == false
        #    erb :'/teams/signup'
        #else
        #    redirect '/tweets'
        #end
    end

    post '/signup' do
        @team = Team.new(:name => params[:name], :username => params[:username], :password => params[:password])
        if params[:name] == "" || params[:username] == "" || params[:password] == ""
          redirect '/signup'
        else
          @team.save
          session[:team_id] = @team.id
          redirect 'teams/show'
        end
    end
    
end