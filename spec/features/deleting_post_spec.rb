require 'rails_helper'

RSpec.feature 'Deleting Post' do
  background do
    user = create(:user)
    post = create(:post, caption: 'delete this post')

    sign_in_with user

    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link 'Edit Post'
  end

  scenario 'can delete a post' do
    click_link 'Delete Post'
    expect(page).to have_content('Post deleted!')
    expect(page).not_to have_content('delete this post')
    expect(page).not_to have_css("img[src*='coffee.jpg']")
  end
end
