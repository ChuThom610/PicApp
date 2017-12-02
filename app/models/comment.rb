class Comment < ApplicationRecord
	belongs_to :pic
	belongs_to :user

	validates_presence_of :user_name, :body
	mount_uploader :picture, PictureUploader  # dung cho cmt bag hinh anh, chua dug toi
end
