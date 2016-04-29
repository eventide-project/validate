module Validate
  module Write
    extend Serialize

    def self.mode
      :serialize
    end

    def self.intermediate
      :raw_data
    end

    def self.call(instance, format_name)
      format = format(instance, format_name)

      raw_data = raw_data(instance)

      assure_mode(format, mode)
      format.serialize(raw_data)
    end

    def self.raw_data(instance)
      serializer = serializer(instance)
      assure_mode(serializer, intermediate)
      serializer.raw_data(instance)
    end
  end
end
