# README

This will be the actions I made to create the webapp:

Add protect_from_forgery :with :exception in =>
 'application_controller.rb'

rails g model Play title:string description:text director:string

rake db:migrate

rails g controller Plays

Add to routes =>
  'resources :plays
  root 'plays#index'
  
Create the file "index.html.erb" inside "/app/views/plays/" and inside the new file add =>
  '<h1> It's running dude! </h1>'
  
Add to Gemfile =>
  gem 'bootstrap-sass', '~> 3.4', '>= 3.4.1'
  gem 'simple_form', '~> 4.1'

Run bundle install

Run rails generate simple_form:install --bootstrap

Add rename "app/assets/stylesheets/application.css" to "application.css.scss" and inside add the following =>
  '@import "bootstrap-sprockets";
   @import "bootstrap";'}'

Inside "app/assets/javascripts/application.js" add =>
  '//= require bootstrap-sprockets'

Restart the server.

Add in plays_controller the following =>

  'def new
   @play = Play.new
  end
  def create
    @play = Play.new(play_params)
  end
  private
  def play_params
    params.require(:play).permit(:title, :description, :director)
  end'

Create in "/app/views/plays" the file called "new.html.erb". Inside that new file add:
 '<h1>  New Broodway Play dude! </h1>
  <%= render 'form' %>'

Then create the partial "_form.html.erb" the following path "/app/views/plays"

Inside that new file add =>

 '<%= simple_form_for @play do |f| %>
    <%= f.input :title %>
    <%= f.input :description %>
    <%= f.input :director %>
    <%= f.button :submit %>
  <% end %>'