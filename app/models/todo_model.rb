require "sinatra/activerecord"

module App
  module Model
    class Todo < ActiveRecord::Base
      belongs_to :lists
    end
  end
end
