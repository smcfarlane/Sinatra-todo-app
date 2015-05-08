require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob('./{app/controllers}/*.rb').each { |file| require file }

map('/') { run App::Controller::AppController }
map('/todos') { run App::Controller::TodosController }
map('/lists') { run App::Controller::ListsController }
