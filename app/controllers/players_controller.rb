class PlayersController < ApplicationController

    get '/players/new' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
          redirect '/login'
        else
          if session[:team_id] == @team.id
              erb :'players/new'
          end
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

    get '/players/:slug' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @player = Player.find_by_slug(params[:slug])
            erb :'players/show'
        end
    end

    get '/players/:slug/edit' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @player = Player.find_by_slug(params[:slug])
            if @player.team_id == session[:team_id]
                erb :'players/edit'
            else
                erb :'errors/player_edit_error'
            end
        end
    end

    patch '/players/:slug' do
      @player = Player.find_by_slug(params[:slug])

      if params["player"]["name"] != ""
          @player.name = params["player"]["name"]
      end

      if !params["player"]["position"].nil?
          @player.position = params["player"]["position"]
      end

      if params["player"]["number"] != ""
          @player.number = params["player"]["number"]
      end
      #if params["country"]
      @player.save
      redirect "players/#{@player.slug}"
     end

     delete '/players/:slug/delete' do
         @team = Helpers.current_team(session)
         if Helpers.is_logged_in?(session) == false
             redirect '/login'
         else
             @player = Player.find_by_slug(params[:slug])
             if @player.team.id == session[:team_id]
                 @player.destroy
                 redirect "teams/#{@team.slug}"
             end
         end
     end
 end
