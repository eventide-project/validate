require_relative '../bench_init'

context "Format has no format methods" do
  example = Serialize::Controls::NoFormatMethods.example
  subject_const = Serialize.subject_const(example)
  serializer = Serialize.get_serializer(subject_const)
  format = Serialize.get_format(:some_format, serializer)

  [Serialize::Read, Serialize::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  context "Serialize" do
    test "Not detected" do
      detected = Serialize.mode?(format, :serialize)
      assert(!detected)
    end
  end

  context "Deserialize" do
    test "Not detected" do
      detected = Serialize.mode?(format, :deserialize)
      assert(!detected)
    end
  end
end
