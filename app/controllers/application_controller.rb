require './config/environment'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

#configuration for sessions
    configure do
      enable :sessions
      set :session_secret, "secret"
    end

#Home page. Redirect to team profile if already logged in.
    get '/' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :home
        else
            redirect "teams/#{@team.slug}"
        end
    end

#Teams index
    get '/teams' do
        @teams = Team.all
        erb :'teams/index'
    end

#Players index
    get '/players' do
        @players = Player.all
        erb :'players/index'
    end

#Countries index
    get '/countries' do
        @countries = Country.all
        erb :'countries/index'
    end

end
