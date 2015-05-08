require 'sinatra'
require "sinatra/activerecord"
require_relative "../models/list_model"
require_relative "../models/todo_model"

module App
  module Controller
    class BaseController < Sinatra::Base
      register Sinatra::ActiveRecordExtension
      configure :development do
        dir = File.dirname(__FILE__).split(%r{/})
        dir = dir.delete_if {|x| x == 'controllers'}
        dir = dir.join('/')
        set :views, dir + '/views/'
        set :public_folder, dir + '/public/'
        set :database, {adapter: "sqlite3", database: "foo.sqlite3"}
      end
    end
  end
end
