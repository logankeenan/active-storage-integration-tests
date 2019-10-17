class Profile < ApplicationRecord
	has_one_attached :profile_picture


	attr_accessor :remove_existing_profile_picture
end