require 'rails_helper'

RSpec.feature 'Deleting Post' do
  background do
    user = create(:user)
    
    visit '/'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log in'

    post = create(:post, caption: 'delete this post')
    visit '/'
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
