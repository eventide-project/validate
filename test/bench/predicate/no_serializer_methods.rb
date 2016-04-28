require_relative '../bench_init'

context "Serializer namespace has no serializer methods" do
  example = Serialize::Controls::NoSerializerMethods.example
  subject_const = Serialize.subject_const(example)
  serializer = Serialize.get_serializer(subject_const)

  [Serialize::Read, Serialize::Write].each do |cls|
    test "#{cls.name} implementation is not detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(!implemented)
    end
  end

  context "Format" do
    test "Not detected" do
      format = Serialize.format_accessor?(:some_format, serializer)
      assert(!format)
    end
  end

  context "Instance" do
    test "Not detected" do
      detected = Serialize.intermediate?(serializer, :instance)
      assert(!detected)
    end
  end

  context "Raw Data" do
    test "Not detected" do
      detected = Serialize.intermediate?(serializer, :raw_data)
      assert(!detected)
    end
  end
end
