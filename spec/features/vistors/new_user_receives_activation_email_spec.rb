require 'rails_helper'
 describe 'Activation email' do

	it 'sends sends an activation link to user' do
    email      = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name  = 'Bob'
    password   = 'password'
    password_confirmation = 'password'

    stub_user_repo_api_requests
    stub_user_followers_api_requests
    stub_user_following_api_requests

    visit '/'

    click_on 'Sign In'
    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'
    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_on 'Create Account'
    expect(current_path).to eq(dashboard_path)
 		expect(page).to have_content("#{first_name}")
		expect(page).to have_content("Please check your email to activate your account")
	end

 	it "account shows not activated" do
    email      = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name  = 'Bob'
    password   = 'password'
    password_confirmation = 'password'

    stub_user_repo_api_requests
    stub_user_followers_api_requests
    stub_user_following_api_requests

    visit '/'

    click_on 'Sign In'
    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'
    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_on 'Create Account'
    expect(current_path).to eq(dashboard_path)
 		visit edit_account_activation_path(:id => User.last.id)

    user = User.last
    user.activate

    visit dashboard_path
 		expect(page).to_not have_content("This account has not yet been activated.")
		expect(page).to have_content("Status: Active")
	end

end
