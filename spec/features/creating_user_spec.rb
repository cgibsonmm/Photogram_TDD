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
end
