module Serialize
  extend self

  class Error < RuntimeError; end

  def format(subject, format_name)
    serializer = serializer(subject)

    assure_format(format_name, serializer)
    get_format(format_name, serializer)
  end

  def get_format(format_name, serializer)
    serializer.send(format_name)
  end

  def serializer(subject)
    subject_const = subject_const(subject)

    assure_serializer(subject_const)
    get_serializer(subject_const)
  end

  def get_serializer(subject_const)
    subject_const.const_get(:Serializer)
  end

  def subject_const(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_serializer(subject_const)
    unless serializer_const?(subject_const)
      raise Error, "#{subject_const.name} doesn't have a `Serializer' namespace"
    end
  end

  def serializer?(subject)
    subject_const = subject_const(subject)
    serializer_const?(subject_const)    
  end

  def serializer_const?(subject_const)
    subject_const.const_defined?(:Serializer)
  end

  def assure_format(format_name, serializer)
    unless format_accessor?(format_name, serializer)
      raise Error, "#{serializer.name} does not implement `#{format_name}'"
    end
  end

  def format_accessor?(format_name, serializer)
    serializer.respond_to?(format_name)
  end

  def format?(format_name, serializer)
    format = get_format(format_name, serializer)
    !!format
  end

  def assure_mode(format, mode)
    unless mode?(format, mode)
      raise Error, "#{format.name} does not implement `#{mode}'"
    end
  end

  def mode?(format, mode)
    format.respond_to?(mode)
  end

  def intermediate?(serializer, intermediate_name)
    serializer.respond_to?(intermediate_name)
  end

  def implemented?(subject, format_name)
    subject_const = subject_const(subject)

    unless serializer_const?(subject_const)
      return false
    end

    serializer = get_serializer(subject_const)

    unless intermediate?(serializer, intermediate)
      return false
    end      

    unless format_accessor?(format_name, serializer)
      return false
    end

    unless format?(format_name, serializer)
      return false
    end

    format = get_format(format_name, serializer)

    unless mode?(format, mode)
      return false
    end

    true
  end
end
