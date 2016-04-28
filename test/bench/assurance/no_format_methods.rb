require_relative '../bench_init'

context "Format has no format methods" do
  example = Serialize::Controls::NoFormatMethods.example

  context "Serialize" do
    test "Is an Error" do
      assert proc { Serialize::Write.(example, :some_format) } do
        raises_error? Serialize::Error
      end
    end
  end

  context "Deserialize" do
    text = Serialize::Controls::Text.example

    test "Is an Error" do
      assert proc { Serialize::Read.(text, example.class, :some_format) } do
        raises_error? Serialize::Error
      end
    end
  end
end
