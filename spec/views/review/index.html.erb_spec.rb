require 'spec_helper'

RSpec.describe "review/index.html.erb" do
  context "When no unreviewed entries exist" do
    it "should display a message saying there are no entries to review" do
      assign(:unreviewed_civil_entries, [])

      render

      expect(rendered).to have_content("There are currently no entries that need to be reviewed.")
    end
  end
  context "When unreviewed entries exist" do
    it "should display those entries with their reasons" do
      assign(:unreviewed_civil_entries, [create(:unreviewed_civil_entry)])

      render

      expect(rendered).to have_content("This is a reason")
      expect(rendered).to have_content("Review this Civility Card")
    end
  end
end
