class CountriesController < ApplicationController

#GET Country show page
    get '/countries/:slug' do
        @country = Country.find_by_slug(params[:slug])
        erb :'/countries/show'
    end

end
