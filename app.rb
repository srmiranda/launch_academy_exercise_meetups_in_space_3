require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'
set :environment, :development

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @title = 'Meet ups in Space'
  meet_ups = Meetup.all.order(:title)
  erb :index, locals: {meet_ups: meet_ups}
end

get '/:id' do
  meet_up = Meetup.find(params['id'])
  attendees = meet_up.users
  erb :show, locals: {meet_up: meet_up, attendees: attendees}
end

post '/' do
  var = Meetup.create(
    title: params[:title],
    description: params[:description],
    location: params[:location]
    )
  redirect "/#{var.id}"
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end

## delete  meet_ups
delete "/:id" do
 id = params['id']
 meet_up = Meetup.find_by id: params['id']
 Meetup.destroy(meet_up)
 redirect "/"
end

## update  meet_ups
get '/:id/update' do
  meet_up = Meetup.find_by id: params['id']
  erb :update, locals: {meet_up: meet_up}
end

# /////
# Join Meetup_inprogress
post '/:id' do
  Usermeetup.new(params['id'], user.id)
  redirect '/:id'
end
# /////

patch "/:id" do
  meet_up = Meetup.all.find_by id: params['id']

  meet_up.update_attribute(:title, params["title"])
  meet_up.update_attribute(:description, params["description"])
  meet_up.update_attribute(:location, params["location"])

  redirect "/"+ params['id']
end
