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
end