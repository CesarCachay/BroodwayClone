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
  
