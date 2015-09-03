# spec/features/admin_spec.rb
require 'spec_helper'

describe "Admin Panel" do
  let(:admin_user) do
    User.create(
      :email => 'user@example.com',
      :password => 'admin123',
      :password_confirmation => 'admin123',
      :admin => true
    )
  end

  before do
    admin_user
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'admin123'
    click_button 'Log in'
  end

  context "when user admin logs in" do
    it "should display a link to the admin panel" do
      expect(page).to have_content 'Admin Panel'
    end
  end
  # context "when non-admin user logs in" do
  #   it "should not display a link to the admin panel" do
  #     expect(page).not_to have_content 'Admin Panel'
  #   end
  # end
end
