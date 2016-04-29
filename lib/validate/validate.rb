module Validate
  extend self

  class Error < RuntimeError; end

  def call(subject, specialization=nil)
    validator = validator(subject)

    if specialization
      validator = specialization(validator, specialization)
    end

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

  def specialization(validator, specialization)
    assure_specialization(validator, specialization)
    get_specialization(validator, specialization)
  end

  def assure_specialization(validator, specialization)
    unless specialization_method?(validator, specialization)
      raise Error, "#{validator.name} doesn't have a `#{specialization}' specialization method"
    end
  end

  def specialization_method?(validator, specialization)
    validator.respond_to?(specialization)
  end

  def get_specialization(validator, specialization)
    validator.public_send(specialization)
  end
end
