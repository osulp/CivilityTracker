require 'spec_helper'

RSpec.describe ReviewController do
  let(:unreviewed_civil_entry) {create(:unreviewed_civil_entry)}
  let(:reviewed_civil_entry) {create(:civil_entry)}
  let(:json_response) {JSON.parse(response.body)}

  context "When there are no entries" do
    before do
      get :index, :format => :json
    end
    it "should not return any objects" do
      expect(json_response.length).to eq 0
    end
  end
  context "When there are entries" do
    context "and those entries are reviewed" do
      before do
        reviewed_civil_entry
        get :index, :format => :json
      end
      it "should return nothing" do
        expect(json_response.length).to eq 0
      end
    end
    context "and those entries are not reviewed" do
      before do
        unreviewed_civil_entry
        get :index, :format => :json
      end
      it "should return the object and it should be unreviewed" do
        expect(json_response.length).to eq 1
        expect(json_response.first["reviewed"]).to eq false
      end
    end
    context "and those entries are both unreviewed and reviewed" do
      before do
        reviewed_civil_entry
        unreviewed_civil_entry
        get :index, :format => :json
      end
      it "should return only the unreviewed object" do
        expect(json_response.length).to eq 1
        expect(json_response.first["reviewed"]).to eq false
      end
    end
  end
end
