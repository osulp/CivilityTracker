require 'spec_helper'

RSpec.describe "review civility card" do
  it "routes /review_item/:id to review#review_card" do
    expect(get("/review_item/1")).to route_to :controller => 'review', :action => 'review_card', :id => "1"
  end
end
