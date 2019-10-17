# frozen_string_literal: true
require 'test_helper'

class ProfileIntegrationTest < ActionDispatch::IntegrationTest
	test 'that a profile can be created' do
		visit new_profile_path

		fill_in "Name", with: 'Jane Doe'

		#this image is located at test/picture_one.jpg
		find(:css, '#profile_profile_picture').set(File.join(Rails.root + "test", 'picture_one.jpg'))

		click_button 'Create Profile'

		assert_current_path profile_path(Profile.order("created_at").last)

		assert_equal ActiveStorage::Attachment.count, 1
	end

	test 'that a profile picture can be removed ' do
		profile = profiles(:remove_existing_profile_picture)
		profile.profile_picture.attach(io: File.open(File.join(Rails.root + "test", 'picture_one.jpg')), filename: 'picture_one.JPG', content_type: 'image/jpeg')
		profile.save!

		visit edit_profile_path(profile)

		find(:css, "#profile_remove_existing_profile_picture").set(true)

		click_button 'Update Profile'

		assert_equal ActiveStorage::Attachment.count, 0
	end
end