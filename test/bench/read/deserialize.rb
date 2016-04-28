require_relative '../bench_init'

context "Deserialize" do
  test "Converts text into an instance" do
    text = Serialize::Controls::Text.example

    control_instance = Serialize::Controls::Instance.example
    example_class = control_instance.class

    instance = Serialize::Read.(text, example_class, :some_format)

    assert(instance == control_instance)
  end
end
