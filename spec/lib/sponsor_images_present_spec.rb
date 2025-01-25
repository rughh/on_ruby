require 'spec_helper'

describe 'Sponsors' do
  Whitelabel.labels.each do |label|
    describe "for '#{label.label_id}'" do
      label.sponsors&.each do |sponsor|
        specify sponsor[:banner] do
          expect(Rails.root.join('app/assets/images/labels').join(label.label_id).join('sponsors').join(sponsor[:banner])).to be_exist
        end
      end
    end
  end
end
