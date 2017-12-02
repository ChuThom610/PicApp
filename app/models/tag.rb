class Tag < ApplicationRecord
	has_many :taggings
	has_many :pics, through: :taggings
end
