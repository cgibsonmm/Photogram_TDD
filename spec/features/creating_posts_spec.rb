require 'rails_helper'

RSpec.feature 'Creating posts' do
  before do
    user = create(:user)
    sign_in_with user
  end
  
  context 'it can create a post' do
    scenario 'can create a post' do
      visit '/'
      click_link 'New Post'
      attach_file('Image', 'spec/files/images/coffee.jpg')
      fill_in 'Caption', with: 'nom nom nom #coffeetime'
      click_button 'Create Post'
      expect(page).to have_content('#coffeetime')
      expect(page).to have_css("img[src*='coffee.jpg']")
    end
  end

  context 'there is an error' do
    it 'must have a photo to create post' do
      visit '/'
      click_link 'New Post'
      fill_in 'Caption', with: "There is no picture"
      click_button 'Create Post'
      expect(page).to have_content('You need a photo to create post!')
    end
  end
end
