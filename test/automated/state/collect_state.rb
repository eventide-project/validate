require_relative '../automated_init'

context "Collect State in Block Argument" do
  example = Validate::Controls::Validator::State.example

  state = []
  result = Validate.(example, state)

  test "State is collected by state object" do
    assert(state.entries.first == :some_entry)
  end
end
