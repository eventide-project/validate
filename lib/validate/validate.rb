module Validate
  extend self

  class Error < RuntimeError; end

  def call(subject, specialization=nil)
    validator = validator(subject, specialization)
    validator.(subject)
  end

  def validator(subject, specialization)
    subject_const = subject_const(subject)

    assure_validator(subject_const, specialization)
    get_validator(subject_const, specialization)
  end

  def subject_const(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_validator(subject_const, specialization)
    unless validator_const?(subject_const)
      raise Error, "#{subject_const.name} doesn't have a `Validator' namespace"
    end
  end

  def validator_const?(subject_const)
    subject_const.const_defined?(:Validator)
  end

  def get_validator(subject_const, specialization)
    subject_const.const_get(:Validator)
  end
end
