require 'sinatra'
require_relative 'base_controller'
require_relative '../app'
require 'pp'

module App
  module Controller
    class AppController < App::Controller::BaseController
      get '/' do
        puts $LOAD_PATH
        slim :'pages/index', locals: { s: 'hello world' }
      end
    end
  end
end
