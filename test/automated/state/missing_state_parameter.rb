require_relative '../automated_init'

context "Collect State When Validator Has No State Parameter" do
  example = Validate::Controls::Validator::Default.example

  state = []

  test "Error" do
    assert_raises Validate::Error do
      Validate.(example, state)
    end
  end
end
