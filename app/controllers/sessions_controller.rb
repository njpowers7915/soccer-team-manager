class SessionsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

    get '/signup' do
        @user = Helpers.current_user(session)
        if Helpers.is_logged_in?(session) == false
            erb :'/teams/signup'
        #else
        #    redirect '/tweets'
        end
    end