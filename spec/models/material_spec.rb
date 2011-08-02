require 'spec_helper'

describe Material do

  it { should allow_values_for(:material_type, *Material::TYPES) }
  it { should_not allow_values_for(:material_type, "bad_type", "") }

end
