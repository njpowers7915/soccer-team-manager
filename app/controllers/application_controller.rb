require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

    get '/' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            erb :home
        else
            redirect "teams/#{@team.slug}"
        end
    end

    get '/teams' do
        @teams = Team.all
        erb :'teams/index'
    end

    get '/players' do
        @players = Player.all
        erb :'players/index'
    end

    get '/countries' do
        @countries = Country.all
        erb :'countries/index'
    end

end
