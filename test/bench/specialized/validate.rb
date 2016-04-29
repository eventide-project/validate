require_relative '../bench_init'

context "Specialized Validate" do
  test "Validates an input" do
    example = Validate::Controls::Validator::Specialized.example

    result = Validate.(example, :some_specialized_validator)

    assert(result == :some_specialized_result)
  end
end
