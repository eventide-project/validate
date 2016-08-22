require_relative '../bench_init'

context "Collect State in Block Argument" do
  example = Validate::Controls::Validator::State.example

  state = OpenStruct.new

  s = nil
  result = Validate.(example) { |state| s = state }

  test "State is collected by state object" do
    assert(s.entries.first == :some_entry)
  end
end
