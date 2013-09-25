require "spec_helper"

describe "events/show" do
  let(:user)  { build(:user, id: 456) }
  let(:event) { build(:event, id: 123) }

  it "should render successfully" do
    view.stub(signed_in?: true, current_user: user, event: event)
    render
  end

  context "materials" do
    let(:materials) { [build(:material)] }

    it "renders without an error" do
      render partial: 'materials', locals: {materials: materials}
    end
  end
end
