require_relative '../bench_init'

context "Class has no serializer namespace" do
  example = Serialize::Controls::NoSerializer.example

  [Serialize::Read, Serialize::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  test "Serializer is not detected" do
    detected = Serialize.serializer?(example)
    assert(!detected)
  end
end
