class Photo < ActiveRecord::Base
	# conver image into base64 format
	mount_base64_uploader :avatar, PhotoUploader
end
