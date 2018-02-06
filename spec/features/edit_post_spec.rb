require 'rails_helper'

RSpec.feature 'Edit post' do
  background do
    user = create(:user)
    post = create(:post, caption: 'Opps!')

    sign_in_with user

    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link 'Edit Post'
  end

  scenario 'can edit a post' do
    fill_in 'Caption', with: 'You were not meant to see that!'
    click_button 'Update Post'

    expect(page).to have_content('Post updated!')
    expect(page).to have_content('You were not meant to see that!')
  end

  context 'Error editing post' do
    it 'requires a photo' do
      attach_file('Image', 'spec/files/coffee.zip')
      click_button 'Update Post'

      expect(page).to have_content('Error updating post!')
    end
  end
end
