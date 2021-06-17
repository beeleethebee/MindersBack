require 'rails_helper'

RSpec.describe "sessions/edit", type: :view do
  before(:each) do
    @session = assign(:session, Session.create!(
      therapist: nil,
      patient: nil
    ))
  end

  it "renders the edit session form" do
    render

    assert_select "form[action=?][method=?]", session_path(@session), "post" do

      assert_select "input[name=?]", "session[therapist_id]"

      assert_select "input[name=?]", "session[patient_id]"
    end
  end
end
