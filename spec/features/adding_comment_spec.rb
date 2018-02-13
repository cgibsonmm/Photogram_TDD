require 'rails_helper'

RSpec.feature 'Adding comments' do
  before do
    user = create(:user)
    @post = create(:post, user_id: user.id)
    sign_in_with user
  end

  scenario 'can add a comment to post' do
    visit '/'
    fill_in 'Add a comment...', with: ';p'
    click_button 'Submit'

    expect(page).to have_content('Created comment!')
    expect(page).to have_css("div#comments_#{@post.id}", text: ';p')
  end
end
