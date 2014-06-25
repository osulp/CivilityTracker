require 'spec_helper'

describe CivilEntry do
  subject {build(:civil_entry)}

  describe "validations" do
    it {should validate_presence_of(:serial)}
  end

end
