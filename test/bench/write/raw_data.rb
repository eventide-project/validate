require_relative '../bench_init'

context "Raw Data" do
  test "Can be retrieved from serializer before it's converted" do
    control_raw_data = Serialize::Controls::RawData.example

    instance = Serialize::Controls::Instance.example

    raw_data = Serialize::Write.raw_data(instance)

    assert(raw_data == control_raw_data)
  end
end
