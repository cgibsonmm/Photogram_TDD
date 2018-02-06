require 'rails_helper'

RSpec.feature 'Edit post' do
  background do
    user = create(:user)
    user_2 = create(:user, email: 'test2@email.com', username: 'testuser2',
                    password: 'testpassword', id: 2)
    post1 = create(:post, caption: 'Opps!', user_id: 1)
    post2 = create(:post, caption: 'User 2 post', user_id: 2)

    sign_in_with user
  end

  def visit_my_post
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link 'Edit Post'
  end

  context 'success editing post' do
    scenario 'owner can edit a post' do
      visit_my_post

      fill_in 'Caption', with: 'You were not meant to see that!'
      click_button 'Update Post'

      expect(page).to have_content('Post updated!')
      expect(page).to have_content('You were not meant to see that!')
    end
  end

  context 'Error editing post' do
    it 'requires a photo' do
      visit_my_post
      attach_file('Image', 'spec/files/coffee.zip')
      click_button 'Update Post'

      expect(page).to have_content('Error updating post!')
    end

    it 'only owner can update post via the show path' do
      find(:xpath, "//a[contains(@href, 'posts/2')]").click
      expect(page).not_to have_content("Edit Post")
    end

    it 'only owner can edit a post' do
      visit 'posts/2/edit'
      expect(page).to have_content('You must own this post to edit it!')
    end
  end
end
