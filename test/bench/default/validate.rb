require_relative '../bench_init'

context "Default Validate" do
  example = Validate::Controls::Validator::Default.example

  result = Validate.(example)

  test "Validates an input" do
    assert(result)
  end
end
