require_relative '../bench_init'

context "Implemented" do
  example = Serialize::Controls::Instance.example

  [Serialize::Read, Serialize::Write].each do |cls|
    test "#{cls.name} implementation is detected" do
      implemented = cls.implemented?(example, :some_format)
      assert(implemented)
    end
  end
end
