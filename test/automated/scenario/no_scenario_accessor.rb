require_relative '../automated_init'

context "Class Has No Validator Scenario Method" do
  example = Validate::Controls::NoScenarioAccessor.example

  test "Error" do
    assert_raises(Validate::Error) do
      Validate.(example, scenario: :some_scenario)
    end
  end
end
