class PhotosController < ApplicationController
	respond_to :json

	# Method for creating the photos
	def create
		photo = Photo.new(avatar: params[:file])
		photo.save
		render :json => photo
	end

	# Method for listing out all photos
	def index
		@photos = Photo.all
		render :json => @photos
	end

	# Method for destroy particular photo
	def destroy
		photo = Photo.find(params[:id])
		photo.destroy
		render :json => Photo.all
	end
end
