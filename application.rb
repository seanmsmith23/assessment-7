require 'sinatra/base'
require 'gschool_database_connection'
require_relative 'models/messages_table'
require './lib/country_list'

class Application < Sinatra::Application

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV['RACK_ENV'])
    @messages = MessagesTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV['RACK_ENV']))
  end

  get '/' do
    erb :index, locals: { :messages => @messages.get_messages}
  end

  post "/add_message" do
    name = params[:name]
    message = params[:message]

    @messages.add_message(name, message)

    redirect '/'
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: { continents: all_continents }
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: { countries: list_of_countries, continent: params[:continent_name] }
  end

end