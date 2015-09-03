require 'spec_helper'

RSpec.describe "admin/index.html.erb" do
  it 'should display a link to review entries' do
    render
    expect(rendered).to have_content "Review Entries"
  end
end
 
