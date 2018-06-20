class CreateTeams < ActiveRecord::Migration
  def change
      create_table :teams do |t|
          t.string :name
          t.string :username
          t.string :password_digest
      end
  end
end
