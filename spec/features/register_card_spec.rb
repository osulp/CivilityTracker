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
