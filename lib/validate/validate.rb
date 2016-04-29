module Validate
  extend self

  class Error < RuntimeError; end

  def call(subject, specialization=nil)
    validator = validator(subject)
    validator.(subject)
  end

  def validator(subject)
    subject_const = subject_const(subject)

    assure_validator(subject_const)
    get_validator(subject_const)
  end

  def subject_const(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_validator(subject_const)
    unless validator_const?(subject_const)
      raise Error, "#{subject_const.name} doesn't have a `Validator' namespace"
    end
  end

  def validator_const?(subject_const)
    subject_const.const_defined?(:Validator)
  end

  def get_validator(subject_const)
    subject_const.const_get(:Validator)
  end

  def validator?(subject)
    subject_const = subject_const(subject)
    validator_const?(subject_const)
  end
end
