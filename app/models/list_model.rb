require "sinatra/activerecord"

module App
  module Model
    class List < ActiveRecord::Base
      has_many :todos
    end
  end
end
