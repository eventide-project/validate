require_relative '../bench_init'

context "Collect State in Block Argument" do
  example = Validate::Controls::Validator::State.example

  state = OpenStruct.new

  result = Validate.(example) do |state|

    test "State is collected by state object" do
      assert(state.entries.first == :some_entry)
    end

  end
end

__END__


s = nil
result = Validate.(example) { |state| s = state }

- - -

s = State.new
Validate.(example, s)

- - -

invoke call
get state
pass it to Block
return boolean


class actuator takes block
- constructs state object
- passess it to block

instance actuator takes state arg
- invokes it
