require_relative '../bench_init'

context "Class Has No Validator Specialization Method" do
  example = Validate::Controls::NoSpecializationAccessor.example

  test "Error" do
    assert proc { Validate.(example, :some_specialized_validator) } do
      raises_error? Validate::Error
    end
  end
end
