require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  before(:each) do
    assign(:session, Session.new(
      therapist: nil,
      patient: nil
    ))
  end

  it "renders new session form" do
    render

    assert_select "form[action=?][method=?]", sessions_path, "post" do

      assert_select "input[name=?]", "session[therapist_id]"

      assert_select "input[name=?]", "session[patient_id]"
    end
  end
end
