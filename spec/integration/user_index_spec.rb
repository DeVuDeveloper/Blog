require 'rails_helper'

RSpec.feature 'Tests for user-index page', type: :feature do
  describe 'user#index' do
    before(:each) do
      @user1 = User.create(name: 'John', photo: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/ea7a3c32163929.567197ac70bda.png',
                           bio: 'Teacher from Mexico.', email: 'john@gmail.com',
                           password: 'johnsecret', confirmed_at: Time.now, post_counter: 0, role: 'admin')
      @user2 = User.create(name: 'Nuri', photo: 'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png',
                           bio: 'Teacher from Mexico.', email: 'photo@gmail.com',
                           password: 'nurisecret', confirmed_at: Time.now, post_counter: 0)
      @user3 = User.create(name: 'Rachid', photo: 'https://static.toiimg.com/thumb/resizemode-4,msid-76729750,imgsize-249247,width-720/76729750.jpg',
                           bio: 'Teacher from Mexico.', email: 'rachid@gmail.com',
                           password: 'rachidsecret', confirmed_at: Time.now, post_counter: 0)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user2.id)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user1.id)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user3.id)
      @post = Post.create(title: 'Testing post-index page', text: 'test for views post-index page',
                          author_id: @user3.id)
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

    scenario 'I can see the number of posts each user has written.' do
      expect(page).to have_content 'Posts(1)'
      expect(page).to have_content 'Posts(2)'
    end

    scenario 'if current users can see admin settings if their role is admin' do
      expect(page).to have_content 'admin settings'
    end

    scenario 'I can see the profile picture for each user.' do
      expect(page.first('img')['src']).to have_content 'https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png'
    end

    scenario "if I click on a user, I am redirected to that user's show page" do
      click_on 'John', match: :first
      expect(current_path).to eq user_path @user1.id
    end
  end
end
