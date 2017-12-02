class Pic < ApplicationRecord
	mount_uploader :picture, PictureUploader
	has_many :comments, dependent: :destroy
	
    belongs_to :album, optional: true
	belongs_to :user, optional: true
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	def self.tagged_with(name)
	  Tag.find_by_name!(name).pics
	end

	def self.tag_counts
	  Tag.select("tags.*, count(taggings.tag_id) as count").
	    joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
	  tags.map(&:name).join(", ")
	end

	def tag_list=(names)
	  self.tags = names.split(",").map do |n|
	    Tag.where(name: n.strip).first_or_create!
	  end
	end
end
