require_relative './automated_init'

context "Result is Not a Boolean Value" do
  example = Validate::Controls::Validator::NotBooleanResult.example

  test "Error" do
    assert_raises Validate::Error do
      Validate.(example)
    end
  end
end
