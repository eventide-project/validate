require_relative '../bench_init'

context "Class has no serializer namespace" do
  example = Serialize::Controls::NoFormat.example
  subject_const = Serialize.subject_const(example)
  serializer = Serialize.get_serializer(subject_const)

  [Serialize::Read, Serialize::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  test "Format is not detected" do
    detected = Serialize.format?(:some_format, serializer)
    assert(!detected)
  end
end
