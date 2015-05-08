require 'sinatra'
require_relative 'base_controller'
require_relative '../app'
require 'pp'

module App
  module Controller
    class TodosController < App::Controller::BaseController
      get '/' do
        @todos = App::Model::Todo.all
        slim :'todos/index', locals: { todos: @todos }
      end

      get '/new' do
        slim :'todos/new'
      end

      post '/new' do
        date = Time.local(Time.now.year, params['month'], params['day'])
        @todo = App::Model::Todo.create(text: params['todo'], done: false, due_date: date)
        @todo.save
        redirect to('/')
      end

      get '/edit/:todoid' do
        @todo = App::Model::Todo.where(id: params['todoid'])
        slim :'todos/edit', locals: { todo: @todo[0] }
      end

      post '/edit/:todoid' do
        @todo = App::Model::Todo.where(id: params['todoid'])[0]
        @todo.text = params['todo']
        date = Time.local(Time.now.year, params['month'], params['day'])
        @todo.due_date = date
        @todo.save
        redirect to('/')
      end

      get '/done/:todoid' do
        @todo = App::Model::Todo.where(id: params['todoid'])[0]
        @todo.done = true
        @todo.save
        redirect to('/')
      end

      get '/delete/:todoid' do
        @todo = App::Model::Todo.where(id: params['todoid'])[0]
        @todo.delete
        redirect to('/')
      end
    end
  end
end
