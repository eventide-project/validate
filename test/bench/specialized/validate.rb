require_relative '../bench_init'

context "Specialized Validate" do
  example = Validate::Controls::Validator::Specialized.example

  result = Validate.(example, :some_specialized_validator)

  test "Validates an input" do
    assert(result == true)
  end
end
