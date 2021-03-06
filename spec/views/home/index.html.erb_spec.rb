require 'spec_helper'

RSpec.describe "home/index.html.erb" do
  let(:user) do
    User.create(
      :email => 'user@example.com',
      :password => 'admin123',
      :password_confirmation => 'admin123',
      :admin => true
    )
  end

  before do
    allow(view).to receive(:current_user).and_return(user) if user
  end
  context "When non-admin user" do
    let(:user) do
      User.create(
        :email => 'user@example.com',
        :password => 'admin123',
        :password_confirmation => 'admin123',
      )
    end
    it "should not display the admin panel" do
      render
      expect(rendered).not_to have_content("Admin Panel")
    end
    it "should not display the delete row" do
      render
      expect(rendered).not_to have_content("Delete")
    end

  end

  context "When signed in as an admin" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => "password"
      click_button "Log in"

      visit admin_index_path
    end
    it "should display the admin panel" do
      expect(page).to have_content("Admin Panel")
    end
    context "on the home page" do
      before do
        visit root_path
      end
      it "should have a row for deleting entries" do
        expect(page).to have_content("Delete")
      end
    end
  end

  context "When no reviewed entries exist" do
    it "should display a message saying there are no civil entries at this time." do
      assign(:civil_entries, [])

      render

      expect(rendered).to have_content("There are currently no entries at this time.")
    end
  end

  context "When reviewed entries exist" do
    it "should display those entries" do
      assign(:civil_entries, [stubbed_model])

      render

      expect(rendered).to have_content("123 Place place")
    end
  end

end

def stubbed_model
  stubbed_model = stub_model(CivilEntry, :address => "123 Place place")
  allow(stubbed_model).to receive(:created_at_formatted).and_return("123")
  stubbed_model
end
