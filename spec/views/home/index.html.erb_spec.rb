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
