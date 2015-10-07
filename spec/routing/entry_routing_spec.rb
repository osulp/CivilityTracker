require 'spec_helper'

RSpec.describe "register civility card" do
  it "routes /entry/:serial to civil_entries#register" do
    expect(get("/entry/1")).to route_to :controller => 'civil_entries', :action => 'register', :serial => "1"
  end
end
