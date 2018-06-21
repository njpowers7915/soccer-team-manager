class TeamsController < ApplicationController

#GET team show page
    get '/teams/:slug' do
        @team = Team.find_by_slug(params[:slug])
        session[:last_visited] = @team.id
        erb :'/teams/show'
    end

end
