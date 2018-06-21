class TeamsController < ApplicationController


    get '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        erb :'teams/show'
    end

end
