require_relative '../bench_init'

context "Collect State When Validator Has No State Parameter" do
  example = Validate::Controls::Validator::Default.example

  test "Error" do
    assert proc { Validate.(example) { |state| } } do
      raises_error? Validate::Error
    end
  end
end
