require 'rails_helper'

RSpec.feature 'Tests for user-index page', type: :feature do
  describe 'user#index' do
    before(:each) do
      @user1 = User.create(name: 'John', photo: 'photo', bio: 'Teacher from Mexico.', email: 'john@gmail.com',
                           password: 'johnsecret', confirmed_at: Time.now, post_counter: 0, role: 'admin')
      @user2 = User.create(name: 'Nuri', photo: 'photo', bio: 'Teacher from Mexico.', email: 'photo@gmail.com',
                           password: 'nurisecret', confirmed_at: Time.now, post_counter: 0)
      @user3 = User.create(name: 'Rachid', photo: 'photo', bio: 'Teacher from Mexico.', email: 'rachid@gmail.com',
                           password: 'rachidsecret', confirmed_at: Time.now, post_counter: 0)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user2.id)
      visit user_session_path

      within 'form' do
        fill_in 'Email', with: @user1.email
        fill_in 'Password', with: @user1.password

        click_button 'Log in'
      end
    end

    scenario 'if user see their names and names of other users' do
      expect(page).to have_content 'John'
      expect(page).to have_content 'Nuri'
      expect(page).to have_content 'Rachid'
    end

    scenario 'if users see posts of other users' do
      expect(page).to have_content 'Posts(1)'
    end

    scenario 'if current users can see admin settings if their role is admin' do
      expect(page).to have_content 'admin settings'
    end
  end
end