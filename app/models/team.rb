class Team < ActiveRecord::Base
    has_many :players
    has_many :country_teams
    has_many :countries, through: :country_teams
    has_secure_password

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
        self.all.detect {|i| i.slug == slug}
    end
end
