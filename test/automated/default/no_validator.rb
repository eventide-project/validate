require_relative '../automated_init'

context "Class Has No Validator Namespace" do
  example = Validate::Controls::NoValidator.example

  test "Error" do
    assert proc { Validate.(example) } do
      raises_error? Validate::Error
    end
  end
end
