require_relative './automated_init'

context "Result is Not a Boolean Value" do
  example = Validate::Controls::Validator::NotBooleanResult.example

  test "Error" do
    assert proc { Validate.(example) } do
      raises_error? Validate::Error
    end
  end
end
