require_relative '../bench_init'

context "Class Has No Validator Specialization Method" do
  test "Error" do
    example = Validate::Controls::NoSpecializationAccessor.example

    assert proc { Validate.(example, :some_specialized_validator) } do
      raises_error? Validate::Error
    end
  end
end
