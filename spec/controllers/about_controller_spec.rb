require 'spec_helper'

RSpec.describe AboutController do
  describe "#index" do
    it "should assign @about_us" do
      FactoryGirl.create(:setting)
      get :index
      expect(assigns(:about_us)).to eq(Setting.about)
    end
    it "should render the index template" do
      get :index
      # binding.pry
      expect(response).to render_template("index")
    end
  end
end
