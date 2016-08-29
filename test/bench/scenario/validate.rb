require_relative '../bench_init'

context "Scenario Validate" do
  example = Validate::Controls::Validator::Scenario.example

  result = Validate.(example, scenario: :some_scenario)

  test "Validates an input" do
    assert(result == true)
  end
end
