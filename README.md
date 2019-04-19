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

# PART 2
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

  # PART 3

In our plays_controller.rb we are going to add the following in the method create =>

  if @play.save
    redirect_to root_path
  else
    render 'new'
  end

After that, we are going able to save and submit new plays in our webapp. Let's save one play in our app for now it will redirect to our current home page! you could check if it was saved in the database using Play.all 

Now, we want to list all our plays that will be saved in our app. For that reason in our "plays_controller.rb" inside the action "index" add =>

  'def index
    @plays = Play.all.order("created_at DESC")
   end'

After that, inside "/app/views/plays/index.html.erb" add this =>

  '<% @plays.each do |play| %>
    <h2><%= link_to play.title, play_path(play)%></h2>
    <% end %>

  <%= link_to "Add Play", new_play_path %>' 

In our plays_controller we are going to add the following =>

 'before_action :find_play, only: [:show, :edit, :update, :destroy] #before "index" action

  def show
  end

  def find_play #inside private
    @play = Play.find(params[:id])
  end'

Create in the path "app/views/plays" the file show.html.erb which will include =>
  <h2><%= @play.title %></h2>
  <h3><%= @play.director %></h3>
  <p><%= @play.description %></p>

After doing that, you could go to "http://localhost:3000/plays/new" and create another play

# PART 4

In the file plays_controller.rb add the following =>

 'def edit
  end

  def update
    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end'

Then, create the file edit.html.erb in the path "/app/views/plays" and type this there =>

 '<h1>  New Broodway Play dude! </h1>
  <%= render 'form' %>'

Inside show.html.erb add to have navigation links =>

 '<%= link_to "Back", root_path %>
  <%= link_to "Edit", edit_play_path(@play)%>
  <%= link_to "Delete", play_path(@play), method: :delete, data: { confirm: "Are you sure?" } %>'











