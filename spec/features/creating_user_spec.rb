require 'rails_helper'


RSpec.feature 'Creating a new user' do
  background do
    visit '/'
    click_link 'Register'
  end

  scenario 'can create a new user via the index page' do
    fill_in 'User name', with: 'sxyrailsdev'
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'user_password', with: 'supersecret'
    fill_in 'user_password_confirmation', with: 'supersecret'

    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  context "can't create user" do
    scenario 'must have a username' do
      fill_in 'Email', with: 'sxyrailsdev@myspace.com'
      fill_in 'user_password', with: 'supersecret'
      fill_in 'user_password_confirmation', with: 'supersecret'

      click_button 'Sign up'
      expect(page).to have_content("can't be blank")
    end

    scenario 'username must be more than 4 chars' do
      fill_in 'User name', with: 'sxy'
      fill_in 'Email', with: 'sxyrailsdev@myspace.com'
      fill_in 'user_password', with: 'supersecret'
      fill_in 'user_password_confirmation', with: 'supersecret'

      click_button 'Sign up'
      expect(page).to have_content('minimum is 4 characters')
    end

    scenario 'username must be less than 12 chars' do
      fill_in 'User name', with: 's' * 13
      fill_in 'Email', with: 'sxyrailsdev@myspace.com'
      fill_in 'user_password', with: 'supersecret'
      fill_in 'user_password_confirmation', with: 'supersecret'

      click_button 'Sign up'
      expect(page).to have_content('maximum is 12 characters')
    end
  end
end
