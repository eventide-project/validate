require_relative '../bench_init'

context "Format has no format methods" do
  example = Serialize::Controls::NoFormatMethods.example

  context "Serialize" do
    test "Is an Error" do
      assert example do
        error? Serialize::Error do
          Serialize::Write.(example, :some_format)
        end
      end
    end
  end

  context "Deserialize" do
    text = Serialize::Controls::Text.example

    test "Is an Error" do
      assert example do
        error? Serialize::Error do
          Serialize::Read.(text, example.class, :some_format)
        end
      end
    end
  end
end
