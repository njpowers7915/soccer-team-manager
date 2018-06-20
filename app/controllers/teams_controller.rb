require 'pry'

class TeamsController < ApplicationController
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    configure do
      enable :sessions
      set :session_secret, "secret"
    end

    get '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        erb :'teams/show'
    end

end