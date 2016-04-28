require_relative '../bench_init'

context "Raw Data" do
  test "Convert raw data into an instance" do
    raw_data = Serialize::Controls::RawData.example
    cls = Serialize::Controls::Instance.example_class
    control_instance = Serialize::Controls::Instance.example

    instance = Serialize::Read.instance(raw_data, cls)

    assert(instance == control_instance)
  end
end
