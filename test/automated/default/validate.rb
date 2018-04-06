require_relative '../automated_init'

context "Default Validate" do
  [Validate::Controls::Validate::Default, Validate::Controls::Validator::Default].each do |control|

    context "#{control.name}" do
      example = control.example

      result = Validate.(example)

      test "Validates an input" do
        assert(result)
      end
    end
  end
end
