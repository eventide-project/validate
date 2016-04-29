module Validate
  module Read
    extend Serialize

    def self.mode
      :deserialize
    end

    def self.intermediate
      :instance
    end

    def self.call(text, cls, format_name)
      format = format(cls, format_name)

      assure_mode(format, mode)
      raw_data = format.deserialize text

      instance(raw_data, cls)
    end

    def self.instance(raw_data, cls)
      serializer = serializer(cls)
      assure_mode(serializer, intermediate)
      serializer.instance(raw_data)
    end
  end
end
