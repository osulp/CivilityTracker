require 'spec_helper'

RSpec.describe AdminController do
  let(:admin_user) do
    User.create(
      :email => 'user@example.com',
      :password => 'admin123',
      :password_confirmation => 'admin123',
      :admin => true
    )
  end

  before do
    admin_user
  end

  describe "#index" do
    context "when the admin user logs in" do
      before do
        get :index
      end
      it 'should display the admin panel' do
        expect(response).to render_template(:index) 
      end
    end
  end
end
 
