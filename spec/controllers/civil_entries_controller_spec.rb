require 'spec_helper'

describe CivilEntriesController do
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
end
