require_relative '../bench_init'

context "Serializer namespace has no serializer methods" do
  example = Serialize::Controls::NoSerializerMethods.example

  context "Format" do
    test "Is an Error" do
      assert example do
        error? Serialize::Error do
          Serialize.format(example, :some_format)
        end
      end
    end
  end

  context "Instance" do
    _ = nil

    test "Is an Error" do
      assert example do
        error? Serialize::Error do
          Serialize::Read.instance(_, example)
        end
      end
    end
  end

  context "Raw Data" do
    test "Is an Error" do
      assert example do
        error? Serialize::Error do
          Serialize::Write.raw_data(example)
        end
      end
    end
  end
end
