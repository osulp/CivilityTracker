require 'spec_helper'

describe "Root Page" do
  before do
    civil_entries
    visit root_path
  end
  context "when there are civil entries" do
    let(:civil_entries) {[civil_entry]}
    let(:civil_entry) {create(:civil_entry)}
    it "should show the serial" do
      expect(page).to have_content(civil_entry.serial)
    end
    it "should show the created_at" do
      expect(page).to have_content(civil_entry.decorate.created_at_formatted)
    end
  end
end
