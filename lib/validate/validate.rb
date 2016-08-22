module Validate
  extend self

  class Error < RuntimeError; end

  def call(subject, specialization=nil, &record_state)
    validator = validator(subject)

    if specialization
      validator = specialization(validator, specialization)
    end

    validate(validator, subject, &record_state)
  end

  def validate(validator, subject, &record_state)
    method = validator.method(:call)

    result = nil
    case method.arity
    when 1
      if block_given?
        raise Error, "State capture block is given but the validator does not provide a state parameter (Validator: #{validator})"
      end

      result = validator.public_send :call, subject
    when 2
      state = State.new
      result = validator.public_send :call, subject, state
      record_state.call(state) if block_given?
    end

    unless result.is_a?(TrueClass) || result.is_a?(FalseClass)
      raise Error, "Result must be boolean. The result is a #{result.class}. (Validator: #{validator})"
    end

    result
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
