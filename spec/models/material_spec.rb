require 'spec_helper'

describe Material do
  describe "validation" do
    it "should validate material_type" do
      material = Factory(:material)
      material.material_type = 'bad_type'
      material.save.should eql(false)
    end
  end
end
