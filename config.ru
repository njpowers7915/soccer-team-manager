require './config/environment'
require 'sinatra'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController
use SessionsController
use TeamsController
use PlayersController
use CountriesController
