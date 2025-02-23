class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    
    @list_of_photos = matching_photos.order({ :created_at => :desc})

    render({ :template => "photos_templates/index.html.erb"})
  end

  def show
    url_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => url_id})
    
    @the_photo = matching_photos.first

    render({ :template => "photos_templates/show.html.erb"})
  end

  def delete
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id})

    the_photo = matching_photos.first
    the_photo.destroy

    redirect_to("/photos")

  end

  def create
    the_image = params.fetch("input_image")
    the_caption = params.fetch("input_caption")
    the_user = params.fetch("input_user")
    
    new_image = Photo.new

    new_image.image = the_image
    new_image.caption = the_caption
    new_image.owner_id = the_user.to_i

    new_image.save

    redirect_to("/photos/" + new_image.id.to_s)
  end

  def update
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({:id => the_id})
    the_photo = matching_photos.first

    the_photo.image = params.fetch("query_image")
    the_photo.caption = params.fetch("query_caption")

    the_photo.save

    redirect_to("/photos/" + the_photo.id.to_s)

  end
end
