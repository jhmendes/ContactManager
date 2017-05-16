require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'

require_relative 'models/contact'
also_reload 'models/contact'

set :bind, '0.0.0.0'  # bind to all interfaces


get '/' do
  @contacts = Contact.limit(5)
  if params[:page].nil?
    @next_page = 2
  end
  erb :index
end

get '/contacts' do

  current_offset = (params[:page].to_i - 1) * 5
# why does this work?
  @contacts = Contact.limit(5).offset(current_offset)
  @next_page = params[:page].to_i + 1
  @last_page = params[:page].to_i - 1
  erb :contacts_index
end

get '/contacts/submit' do
  erb :submit_contact
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :show
end

post '/contacts' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @contact = Contact.where(first_name: @first_name, last_name: @last_name)
  erb :search
end

post '/contacts/submit' do
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @phone_number = params[:phone]
  # change this to new/save and use valid?
  Contact.create(first_name: @first_name, last_name: @last_name, phone_number: @phone_number)
  @contacts = Contact.all
  erb :index
end
