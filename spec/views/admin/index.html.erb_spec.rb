require 'spec_helper'

RSpec.describe "admin/index.html.erb" do
  let(:user) {create(:user, :admin)}
  context "when logged in as an admin" do
    before do
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "password"
      click_button "Log in"

      visit admin_index_path
    end
    it 'should display a link to review entries' do
      expect(page).to have_content "Review Entries"
    end
  end
end
 
