class CountryTeam < ActiveRecord::Base
    belongs_to :country
    belongs_to :team
end
