require_relative '../bench_init'

context "Default Validate" do
  test "Validates an input" do
    example = Validate::Controls::Validator::Default.example

    result = Validate.(example)

    assert(result == :some_default_result)
  end
end
