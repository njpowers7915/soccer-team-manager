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
end
