require 'rails_helper'

RSpec.feature 'View post index' do
  before do
    user = create(:user)

    sign_in_with user
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
