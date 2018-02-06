require 'rails_helper'

RSpec.feature 'View post index' do
  before do
    user = create(:user)

    visit '/'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log in'
  end
  scenario 'can see index of all posts' do
    post_one = create(:post, caption: 'This is post one.')
    post_two = create(:post, caption: 'This is post two.')

    visit '/'
    expect(page).to have_content('This is post one.')
    expect(page).to have_content('This is post two.')
    expect(page).to have_css("img[src*='coffee']")
  end
end
