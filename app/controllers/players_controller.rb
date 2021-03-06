class PlayersController < ApplicationController

#Create new player
    get '/players/new' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
          redirect '/login'
        else
          if session[:team_id] == session[:last_visited]
              erb :'players/new'
          else
              erb :'/errors/add_player_error'
          end
        end
    end 

#POST new player route
    post '/players/new' do
        if params["player"].values.include?("") #|| params["country"]["name"] == ""
            redirect '/players/new'
        else
            @player = Player.new(params["player"])
            @player.team = Team.find_by(id: session["team_id"])

            if params["country"]["name"] != ""
                country = Country.find_by(name: params["country"]["name"])
                if country.nil?
                    new_country = Country.new(name: params["country"]["name"])
                    new_country.save
                    @player.country = new_country
                else
                    @player.country = country
                end
            else
                @player.country = Country.find_by(id: params["player"]["country_id"])
            end

        @player.save
        redirect "teams/#{@player.team.slug}"
        end
    end

#GET individual player's show page
    get '/players/:slug' do
        @team = Helpers.current_team(session)
        if Helpers.is_logged_in?(session) == false
            redirect '/login'
        else
            @player = Player.find_by_slug(params[:slug])
            session[:last_visited] = @player.id
            erb :'players/show'
        end
    end

#GET edit page for individual player
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

#Edit form for individual player
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

      if params["country"]["name"] != ""
          country = Country.find_by(name: params["country"]["name"])
          if country.nil?
              new_country = Country.new(name: params["country"]["name"])
              new_country.save
              @player.country = new_country
          else
              @player.country = country
          end
      elsif params["country"]["name"] == "" && !params["player"]["country_id"].nil?
          @player.country = Country.find_by(id: params["player"]["country_id"])
      end

      @player.save
      redirect "players/#{@player.slug}"
     end

#Delete form for individual player
     delete '/players/:slug/delete' do
         @team = Helpers.current_team(session)
         if Helpers.is_logged_in?(session) == false
             redirect '/teams/login'
         else
             @player = Player.find_by_slug(params[:slug])
             if @player.team.id == session[:team_id]
                 @player.destroy
                 redirect "/teams/#{@team.slug}"
             else
                 erb :'/errors/player_edit_error'
             end
         end
     end
 end
