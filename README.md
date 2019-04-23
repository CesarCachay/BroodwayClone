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
'<h1> New Broodway Play dude! </h1>
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

After that, we are going able to save and submit new plays in our webapp. Let's save one play in our app for now it will
redirect to our current home page! you could check if it was saved in the database using Play.all

Now, we want to list all our plays that will be saved in our app. For that reason in our "plays_controller.rb" inside
the action "index" add =>

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

'<h1> New Broodway Play dude! </h1>
<%= render 'form' %>'

Inside show.html.erb add to have navigation links =>

'<%= link_to "Back", root_path %>
<%= link_to "Edit", edit_play_path(@play)%>
<%= link_to "Delete", play_path(@play), method: :delete, data: { confirm: "Are you sure?" } %>'

# PART 5
Add the new gem for users and then, bundle install
gem 'devise', '~> 4.6', '>= 4.6.2'

Second, use the command: "rails generate devise:install" to include this gem in our project

Third, add this line in development.rb
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

The next step is in our application.html.erb in our body we need to write this

<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>

<div class="container">
  <%= yield %>
</div>

Fifth, you could create another play to have more data, and run the commands =>

rails g devise:views
rails g devise User
rails db:migrate

Then, go to "http://localhost:3000/users/sign_up" and create 1 user

# PART 6

In the body of our application.html.erb add the following =>

      <nav class="navbar navbar-default">
      <div class="container">
        <div class="navbar-header">
          <%= link_to "Broadway", root_path, class: "navbar-brand" %>
        </div>

        <ul class="nav navbar-nav navbar-right">
          <% if user_signed_in? %>
            <li><%= link_to "Sign Out", destroy_user_session_path, method: :delete %></li>
          <% else %>
            <li><%= link_to "Sign Up", new_user_registration_path %></li>
            <li><%= link_to "Log In", new_user_session_path %></li>
          <% end %>
        </ul>

        <ul class="nav navbar-nav">
          <% if user_signed_in? %>
            <li><%= link_to "Add Play", new_play_path %></li>
          <% end %>
      </div>
    </nav>

Then, reload the webapp and sign out the current user.

Now, run the command => "rails g migration_add_user_id_to_plays user_id:integer" and proceed with "rails db:migrate"

 # PART 7

First, we need to refactor our "plays_controller.rb" with the following => 

  def new
   @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)
    if @play.save
      redirect_to root_path
    else
      render 'new'
    end
  end

Second, in the file "index.html.erb" we are going to get of rid this line =>

  <%= link_to "Add Play", new_play_path %>

Third, Log In with the user you created. After that we need to link the models "user and play" including this lines =>

  In the class inside of the file "user.rb" write this line => has_many :plays
  Inside the class of the file "play.rb" add => belongs_to :user

Next step is in the file "show.html.erb" delete: <%= link_to "Back", root_path %> AND refactor like this =>

  <div class="links btn-group"> 
    <% if user_signed_in? %>
      <% if @play.user_id == current_user.id %>
        <%= link_to "Edit", edit_play_path(@play)%>
        <%= link_to "Delete", play_path(@play), method: :delete, data: { confirm: "Are you sure?" } %>
      <% end %>
    <% end %> 
  </div>

Now, we will run the command => 

  rails g model Category name:string
  rails g migration add_category_id_to_plays category_id:integer
  rails db:migrate

Then, we need to link the new model adding =>

 In the file "play.rb" => belongs_to :category 
 In "category.rb" => has_many :plays

 
  #PART 8

In "plays_controller.rb" add the following =>

  def new
   @categories = Category.all.map{ |c| [c.name, c.id]} #this is the new line added in this action!
  end

  def create
    @play.category_id = params[:category_id]
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  def update
    @play.category_id = params[:category_id]
  end

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id)
  end

Second in this part we need to add inside the block of the file "_form.html.erb" =>

  <%= select_tag(:category_id, options_for_select(@categories), :prompt => "Select Category" ) %>

Then, open rails c and run the following =>

  Category.create(name: "Classical")
  Category.create(name: "Drama")
  Category.create(name: "Comedy")
  Category.all

The next step is the enter into the rails console and assign manually the categories to our existing plays run this

  rails c 
  @play = Play.first
  @play.category_id = 1
  @play.save
  @play2 = Play.second
  @play2.category_id = 3
  @play2.save
  @play6 = Play.find(6) #with this command "find" rails will detect by default the "id"
  @play6.category_id = 2
  @play6.save
  
Finally, to show in our browser the categories of our plays let's add in "_form.html.erb" =>

  <h4><%= @play.category.name %></h4>


  #PART 8
First, in our file "edit.html.erb" we are going to delete the line => render 'form' and add =>

  <%= simple_form_for @play, html: {multipart: true} do |f| %> # {multipart: true} will allow us to upload images
    <%= f.select :category_id, @categories %>
    <%= f.input :title, label: "Play Title"%>
    <%= f.input :description %>
    <%= f.input :director %>
    <%= f.button :submit %>
  <% end %>

Second, in "application.html.erb" we need to add the following =>

  <ul class="nav navbar-nav">
    <li class="dropdown"> 
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Sort <span class="caret"></span></a>
        <ul class="dropdown-menu" role="menu">
          <% Category.all.each do |category| %>
            <li class="<%= 'active' if params[:category] == category.name %>">
              <%= link_to category.name, plays_path(category: category.name), class: "link" %>
            </li>
          <% end %>
      </ul>
    </li>

    <% if user_signed_in? %>
      <li><%= link_to "Add Play", new_play_path %></li>
    <% end %>
  </ul>


Third, in our plays_controller.rb add in the action index the following =>

  def index
    if params[:category].blank?
      @plays = Play.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id 
      @plays = Play.where(:category_id => @category_id).order("created_at")
    end
  end

Finally, inside index.html.erb we are going to inclue the next lines =>

  <h1 class="current-category"><%= params[:category]%></h1>

  <% if @plays.count == 0 %>
    <h3>There are no plays in this category</h3>
  <% else %>
    <% @plays.each do |play| %>
      <h2><%= link_to play.title, play_path(play)%></h2>
    <% end %>
  <% end %>

  # PART 9 (IMAGE UPLOADING)

  brew install imagemagick
  brew install gs
  gem 'paperclip', '~> 6.1'  

Then, bundle install. After doing that you need to go to "play.rb" and add the following inside its class =>

  class User < ActiveRecord::Base
    has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  end

Second in development mode, you might add this line to config/environments/development.rb:

  Paperclip.options[:command_path] = "/usr/local/bin/"

Third, run the following command =>

  rails g paperclip Play avatar
  rails db:migrate
  rails server

The next step is going to the file "_form.html.erb" and include this line before "selected_tag" also in "edit.html.erb" you should add before "f.select :category_id, @categories"

  <%= f.file_field :avatar %>

Finally in "plays_controller.rb" after private we need to add in our method play_params like this =>

    def play_params
      params.require(:play).permit(:title, :description, :director, :category_id, :avatar)
    end

Then, we need to show the images because now we are able to save images and we can check it in the console but to show in our index we will add in the file "index.html.erb" =>

  <h1 class="current-category"><%= params[:category]%></h1>

  <% if @plays.count == 0 %>
    <h3>There are no plays in this category</h3>
  <% else %>
    <div class="row">
      <% @plays.each do |play| %>
        <div class="col-md-3">
          <a href="/plays/ <%= play.id %>">
            <%= image_tag play.avatar.url(:medium), class: "play" %> 
          </a>
        </div>
      <% end %>
    </div>
  <% end %>

Now If we refresh our webapp we can see now our pictures but they are in different sizes for that reason now we move to "application.css.scss" and add =>

  .play {
    height: 350px;
    width: 250px;
  }

  # PART 10

Run the following command 
  rails g model Review rating:integer comment:text
  rake db:migrate
  rails g migration add_user_id_to_reviews user_id:integer
  rake db:migrate
  rails g migration add_play_id_to_reviews play_id:integer

Add associations in our models 

  In review.rb =>

    class Review < ApplicationRecord
      belongs_to :play
      belongs_to :user
    end

  In user.rb =>

    class User < ApplicationRecord
      has_many :plays
      has_many :reviews
      devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

      devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]

      def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
        end
      end
    end


  In play.rb =>

    class Play < ApplicationRecord
      belongs_to :user
      belongs_to :category
      has_many :reviews
      validates :title, presence: true
      validates :description, presence: true
      validates :director, presence: true
      validates :category_id, presence: true

      has_attached_file :avatar, styles: { medium: "250x350>", thumb: "250x250>" }, default_url: "/images/:style/missing.png"
      validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    end







