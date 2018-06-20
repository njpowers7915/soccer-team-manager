class PlayersController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

    get '/players/new' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
          redirect '/login'
        else
          erb :'players/new'
        end
    end

    post '/players/new' do
        if params["player"].values.include?("") #|| params["country"]["name"] == ""
            redirect '/players/new'
        else
            @player = Player.new(params["player"])
            @player.team = Team.find_by(id: session["team_id"])
            @player.country = Country.find_by(name: params["country"]["name"])
            country_team = CountryTeam.new
            #country_team.team_id = @player.team.id
            #country_team.country_id = @player.country.id
            #@player.country
            @player.save
            redirect "teams/#{@player.team.slug}"
        end
    end

    get 'players/:slug' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @player = Player.find_by_slug(params[:slug])
            erb :'/players/show'
        end
    end
end
