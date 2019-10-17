require_relative '../automated_init'

context "Class Has No Validator Namespace" do
  example = Validate::Controls::NoValidator.example

  test "Error" do
    assert_raises(Validate::Error) do
      Validate.(example)
    end
  end
end
