require_relative '../bench_init'

context "Serializer has no format namespace" do
  test "Is an error" do
    example = Serialize::Controls::NoFormat.example
    subject_const = Serialize.subject_const(example)
    serializer = Serialize.get_serializer(subject_const)

    assert example do
      error? Serialize::Error do
        Serialize.format(serializer, :some_format)
      end
    end
  end
end
