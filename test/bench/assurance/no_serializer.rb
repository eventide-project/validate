require_relative '../bench_init'

context "Class has no serializer namespace" do
  test "Is an error" do
    example = Serialize::Controls::NoSerializer.example

    assert example do
      error? Serialize::Error do
        Serialize.serializer example
      end
    end
  end
end
