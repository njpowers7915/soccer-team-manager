class CreateCountryTeams < ActiveRecord::Migration
  def change
      create_table :country_teams do |t|
          t.integer :country_id
          t.integer :team_id
      end
  end
end
