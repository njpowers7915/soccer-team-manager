class Team < ActiveRecord::Base
    has_many :players
    has_many :country_teams
    has_many :countries, through: :country_teams
end
