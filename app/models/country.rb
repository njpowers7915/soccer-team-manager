class Country < ActiveRecord::Base
    has_many :players
    has_many :country_teams
    has_many :teams, through: :country_teams
end
