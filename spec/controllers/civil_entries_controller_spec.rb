require 'spec_helper'

describe CivilEntriesController do
  let(:civil_entry) {create(:civil_entry)}
  let(:civil_hash) {{:latitude => 1, :longitude => 2, :reason => "blah"}}

  describe '#index' do
    context "when there are only reviewed civil entries" do
      before do
        2.times {create(:civil_entry)}
        get :index, :format => :json
      end
      it "should return all civil entries" do
        expect(JSON.parse(response.body).length).to eq 2
      end
    end
    context "when there are not any reviewed civil entries" do
      before do
        2.times {create(:civil_entry, :unreviewed_civil_entry)}
        get :index, :format => :json
      end
      it "should return not return any civil entries" do
        expect(JSON.parse(response.body).length).to eq 0
      end
    end
    context "when there are both reviewed and unreviewed civil entries" do
      before do
        2.times {create(:civil_entry)}
        2.times {create(:civil_entry, :unreviewed_civil_entry)}
        get :index, :format => :json
      end
      it "should return only reviewed civil entries" do
        expect(JSON.parse(response.body).length).to eq 2
      end
    end

  end
  describe '#update' do
    context "after updating" do
      before do
        put :update, :id => civil_entry, :civil_entry => civil_hash
      end
      it "should update and redirect to the root path" do
        expect(response).to redirect_to root_path
        expect(flash[:success]).to have_content("Thank you for submitting an entry. Your card is currently under review")
      end
    end
  end
 
end
