require_relative '../automated_init'

context "Class Has No Validator Scenario Method" do
  example = Validate::Controls::NoScenarioAccessor.example

  test "Error" do
    assert proc { Validate.(example, scenario: :some_scenario) } do
      raises_error? Validate::Error
    end
  end
end
