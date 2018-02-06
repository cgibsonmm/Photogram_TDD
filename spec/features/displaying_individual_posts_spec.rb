require 'rails_helper'

RSpec.describe 'Displaying indivdual posts' do
  before do
    user = create(:user)
    sign_in_with user
  end

  scenario 'can view single post' do
    post_one = create(:post, caption: 'This is one to click', user_id: 1)
    post_two = create(:post, caption: 'This is post two.', user_id: 1)

    visit '/'
    find(:xpath, "//a[contains(@href, 'posts/1')]").click

    expect(page.current_path).to eq(post_path(post_one))
    expect(page).to have_content('This is one to click')
    expect(page).not_to have_content('This is post two.')
    expect(page).to have_css("img[src*='coffee']")
  end
end
