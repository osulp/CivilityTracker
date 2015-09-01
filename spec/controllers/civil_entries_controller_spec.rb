require 'spec_helper'

describe CivilEntriesController do
  let(:civil_entry) {create(:civil_entry)}
  let(:civil_hash) {{:latitude => 1, :longitude => 2, :reason => "blah"}}
  describe '#index' do
    context "when there are civil entries" do
      before do
        2.times {create(:civil_entry)}
        get :index, :format => :json
      end
      it "should return all civil entries" do
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
      end
    end
  end
 
end
