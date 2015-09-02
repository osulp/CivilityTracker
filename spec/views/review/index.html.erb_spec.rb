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
      assign(:unreviewed_civil_entries, [create(:civil_entry, :reviewed => false, :reason => "All the reasons!")])

      render

      expect(rendered).to have_content("All the reasons!")
    end
  end
end
