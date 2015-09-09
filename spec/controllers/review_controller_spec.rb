require 'spec_helper'

RSpec.describe ReviewController do
  let(:unreviewed_civil_entry) {create(:civil_entry, :unreviewed_civil_entry)}
  let(:reviewed_civil_entry) {create(:civil_entry)}
  let(:json_response) {JSON.parse(response.body)}
  let(:user) {nil}

  context "When not logged in as an admin" do
    before do
      sign_in(user) if user
    end
    context "It should redirect you to the homepage" do
      before do
        get :index
      end
      it "should redirect to the homepage" do
        expect(response).to be_redirect
      end
    end
  end
  context "When signed in as an admin" do
    let(:user) do
      User.create(
          :email => 'user@example.com',
          :password => 'admin123',
          :password_confirmation => 'admin123',
          :admin => true
        )
    end
    before do
      sign_in(user) if user
    end
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

    context "#review_card" do
      before do
        get :review_card, :id => unreviewed_civil_entry.id, :format => :json
      end

      it "should set the card to reviewed" do
        expect(unreviewed_civil_entry.reviewed).to eq false
        expect(json_response["reviewed"]).to eq true
      end
    end
    context "#destroy" do
      it "should delete the entry" do
        reviewed_civil_entry
        expect(CivilEntry.all.length).to eq 1

        get :destroy, :id => reviewed_civil_entry.id, :format => :json

        expect(CivilEntry.all.length).to eq 0
      end
    end
  end
end
