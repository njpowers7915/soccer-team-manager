class Player < ActiveRecord::Base
    belongs_to :team
    belongs_to :country

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
        self.all.detect {|i| i.slug == slug}
    end
end
