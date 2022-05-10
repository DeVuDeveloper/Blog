require 'rails_helper'

RSpec.feature 'Tests for user/show page', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', photo: 'photo', bio: 'Teacher from Mexico.', email: 'john@gmail.com',
                        password: 'johnsecret', confirmed_at: Time.now, post_counter: 0, role: 'admin')
    Post.create(title: 'Testing with capybara', text: 'test for views', author_id: @user.id)
    visit user_session_path
    within 'form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
  end

  scenario 'if users in user/show page can see their name' do
    first(:link, href: user_path(@user.id)).click
    expect(page).to have_content 'John'
  end

  scenario 'if users in user/show page can see their posts' do
    first(:link, href: user_path(@user.id)).click
    expect(page).to have_content 'Posts(1)'
  end

  scenario 'if users can see their Bio ' do
    first(:link, href: user_path(@user.id)).click
    expect(page).to have_content @user.bio
  end

  scenario 'if current users can see numbers of their posts' do
    first(:link, href: user_path(@user.id)).click
    expect(page).to have_content 'Posts(1)'
  end

  scenario 'if users can see link to all posts' do
    first(:link, href: user_path(@user.id)).click
    expect(page.has_link?('See all posts')).to be true
  end
end
