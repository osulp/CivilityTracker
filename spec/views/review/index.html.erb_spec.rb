require 'spec_helper'

RSpec.describe "review/index.html.erb" do
  let(:user) {create(:user, :admin)}
  context "When no unreviewed entries exist" do
    before do
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "password"
      click_button "Log in"
      assign(:unreviewed_civil_entries, [])

      visit review_index_path
    end
    it "should display a message saying there are no entries to review" do
      expect(page).to have_content("There are currently no entries that need to be reviewed.")
    end
  end
  context "When unreviewed entries exist" do
    before do
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "password"
      click_button "Log in"
      assign(:unreviewed_civil_entries, [create(:civil_entry, :unreviewed_civil_entry)])

      visit review_index_path
    end
    it "should display those entries with their reasons" do
      expect(page).to have_content("This is a reason")
      expect(page).to have_content("Approve this Entry")
      expect(page).to have_content("Delete this Entry")
    end
  end
end
