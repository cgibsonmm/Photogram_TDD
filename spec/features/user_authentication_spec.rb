require 'rails_helper'

RSpec.feature 'User authentication' do
  background do
    user = create(:user)
  end

  context 'Successful log in' do
    scenario 'can log in from the index via dynamic navbar' do
      visit '/'
      expect(page).not_to have_content('New Post')

      click_link 'Login'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
      expect(page).not_to have_content('Register')
      expect(page).to have_content('Logout')
    end
  end

  context 'Successful Logout' do
    scenario 'user can log out once logged in' do
      visit '/'
      click_link 'Login'

      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Log in'
      click_link 'Logout'
      expect(page).to have_content('You need to sign in or sign up')
    end
  end

  context 'protecting post form user that is not logged in' do
    scenario 'cannot view index post without logging in' do
      visit '/'
      expect(page).to have_content('You need to sign in or sign up')
    end

    scenario 'cannot create a new post without logging in' do
      visit new_post_path
      expect(page).to have_content('You need to sign in or sign up')
    end
  end
end
