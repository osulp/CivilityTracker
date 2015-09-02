require 'spec_helper'

RSpec.describe "home/index.html.erb" do
  context "When no reviewed entries exist" do
    it "should display a message saying there are no civil entries at this time." do
      assign(:civil_entries, [])

      render

      expect(rendered).to have_content("There are currently no entries at this time.")
    end
  end
  context "When reviewed entries exist" do
    it "should display those entries with their reasons" do
      assign(:civil_entries, [create(:civil_entry, :reviewed => true, :address => "123 Place place")])

      render

      expect(rendered).to have_content("123 Place place")
    end
  end
end
