require 'spec_helper'

describe "registering a card" do
  context "when a card's path is visited" do
    let(:serial) {rand(3000)}
    let(:loading) { find("h3.loading") }
    let(:wait_notification) { "Retrieving location, please wait..." }
    before do
      visit register_civil_entries_path(:serial => serial)
    end

    it "should display loading indicator to retrieve location" do
      expect(loading.text).to have_content(wait_notification)
      expect(loading).to be_visible
    end
    it "should create a civil entry" do
      expect(CivilEntry.count).to eq 1
    end
    it "should store the lat/lng of the user", :geolocation => true, :js => true do
      page.execute_script(%Q($("#getLocation").trigger('click')))
      expect(CivilEntry.first.latitude).to eq 44.56222682932014
    end
    it "should display their location", :geolocation => true, :js => true do
      page.execute_script(%Q($("#getLocation").trigger('click')))
      expect(page).to have_content("Corvallis, Oregon, United States")
      expect(page).not_to have_content(wait_notification)
    end
    it "should only accept the lat/lng of the user once", :geolocation => true, :js => true do
      page.execute_script(%Q($("#getLocation").trigger('click')))
      expect(CivilEntry.first.latitude).to eq 44.56222682932014
      expect(CivilEntry.any_instance).not_to receive(:longitude=)
      page.execute_script("window.GeolocationUpdater.updateSerial({coords: {longitude: 3, latitude: 2}});")
      expect(CivilEntry.first.latitude).not_to eq 2
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
