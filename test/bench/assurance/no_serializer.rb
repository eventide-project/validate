require_relative '../bench_init'

context "Class has no serializer namespace" do
  test "Is an error" do
    example = Serialize::Controls::NoSerializer.example

    assert proc { Serialize.serializer example } do
      raises_error? Serialize::Error
    end
  end
end
