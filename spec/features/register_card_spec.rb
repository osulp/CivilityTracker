require 'spec_helper'

describe "registering a card" do
  context "when a card's path is visited" do
    let(:serial) {rand(3000)}
    before do
      visit register_civil_entries_path(:serial => serial)
    end
    it "should create a civil entry" do
      expect(CivilEntry.count).to eq 1
    end
    it "should store the lat/lng of the user", :geolocation => true, :js => true do
      expect(CivilEntry.first.latitude).to eq 44.56222682932014
    end
    it "should only accept the lat/lng of the user once", :geolocation => true, :js => true do
      expect(CivilEntry.first.latitude).to eq 44.56222682932014
      expect(CivilEntry.any_instance).not_to receive(:longitude=)
      visit register_civil_entries_path(:serial => serial)
    end
    it "should have a way to add a note" do
      expect(page).to have_field("civil_entry_reason")
    end
    context "and the reason is filled out" do
      before do
        fill_in "civil_entry_reason", :with => "Someone was suuuper nice."
        click_button "Submit"
      end
      it "should save the reason" do
        expect(CivilEntry.first.reason).to eq "Someone was suuuper nice."
      end
    end
    context "and then it's visited again" do
      before do
        visit register_civil_entries_path(:serial => serial)
      end
      it "should not create another entry" do
        expect(CivilEntry.count).to eq 1
      end
    end
  end
end
