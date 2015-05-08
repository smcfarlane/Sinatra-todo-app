require 'sinatra'
require_relative 'base_controller'
require_relative '../app'
require 'pp'

module App
  module Controller
    class ListsController < App::Controller::BaseController
      include App
      get '/' do
        @lists = App::Model::List.all
        slim :'lists/index', locals: { lists: @lists }
      end

      get '/show/:list_id' do
        @list = App::Model::List.find(params['list_id'])
        slim :'lists/show', locals: { list: @list }
      end

      get '/new' do
        slim :'lists/new'
      end

      post '/new' do
        @list = App::Model::List.create(name: params['name'])
        @list.save
        redirect to("/show/#{@list.id}")
      end

      get '/new/list-todo/:list_id' do
        @list = @list = App::Model::List.find(params['list_id'])
        slim :'lists/new-todo', locals: { list: @list }
      end

      post '/new/list-todo/:list_id' do
        date = Time.local(Time.now.year, params['month'], params['day'])
        @list = App::Model::List.find(params['list_id'])
        @list_todo = @list.todos.create(text: params['todo'], done: false, due_date: date)
        @list_todo.save
        redirect to("/show/#{@list.id}")
      end

      get '/mark-done/:list_id/:todo_id' do
        @todo = App::Model::Todo.find(params['todo_id'])
        @todo.done = true
        @todo.save
        if request.referrer.include? 'show'
          redirect to("/show/#{params['todo_id']}")
        else
          redirect to("/")
        end
      end

      get '/delete/:list_id' do
        @list = App::Model::List.find(params['list_id'])
        @todos = @list.todos.all
        @todos.each { |t| t.delete }
        @list.delete
        redirect to("/")
      end
    end
  end
end
