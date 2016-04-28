require_relative '../bench_init'

context "Serializer namespace has no serializer methods" do
  example = Serialize::Controls::NoSerializerMethods.example

  context "Format" do
    test "Is an Error" do
      assert proc { Serialize.format(example, :some_format) } do
        raises_error? Serialize::Error
      end
    end
  end

  context "Instance" do
    _ = nil

    test "Is an Error" do
      assert proc { Serialize::Read.instance(_, example) } do
        raises_error? Serialize::Error
      end
    end
  end

  context "Raw Data" do
    test "Is an Error" do
      assert proc { Serialize::Write.raw_data(example) } do
        raises_error? Serialize::Error
      end
    end
  end
end
