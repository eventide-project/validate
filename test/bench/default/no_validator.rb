require_relative '../bench_init'

context "Class Has No Validator Namespace" do
  test "Error" do
    example = Validate::Controls::NoValidator.example

    assert proc { Validate.(example) } do
      raises_error? Validate::Error
    end
  end
end
