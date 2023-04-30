class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({:username => :asc})
    render({ :template => "user_templates/index.html.erb"})
  end

  def show
    #Parameters: {"path_username"=>"anisa"}
    url_username = params.fetch("path_username") 
    
    matching_usernames = User.where({ :username => url_username})
    @the_user = matching_usernames.first

    if @the_user == nil
      redirect_to("/404")
    else
      render({ :template => "user_templates/show.html.erb"})
    end
  end

def create
  input_username = params.fetch("query_username")
  new_user = User.new

  new_user.username = input_username
  new_user.save

  redirect_to("/users")
  #render({ :template => "user_templates/temp.html.erb"})
end

def update
  the_id = params.fetch("path_id")
  
  the_user = User.find_by({:id => the_id})
  
  input_username = params.fetch("query_username")
  the_user.username = input_username
 
  the_user.save

  redirect_to("/users/" + input_username)
end

end
