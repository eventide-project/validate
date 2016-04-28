require_relative '../bench_init'

context "Serialize" do
  test "Converts an instance into text" do
    control_text = Serialize::Controls::Text.example

    instance = Serialize::Controls::Instance.example

    text = Serialize::Write.(instance, :some_format)

    assert(text == control_text)
  end
end
