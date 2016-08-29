module Validate
  extend self

  class Error < RuntimeError; end

  def call(subject, state=nil, scenario: nil)
    validator = validator(subject)

    if !scenario.nil?
      validator = scenario(validator, scenario)
    end

    validate(validator, subject, state)
  end

  def validate(validator, subject, state)
pp validator
    method = validator.method(:call)

    result = nil
    case method.arity
    when 1
      if block_given?
        raise Error, "State argument was supplied but the validator does not provide a state parameter (Validator: #{validator})"
      end

      result = validator.public_send :call, subject
    when 2
      result = validator.public_send :call, subject, state
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

  def scenario(validator, scenario)
    assure_specialization(validator, scenario)
    get_specialization(validator, scenario)
  end

  def assure_specialization(validator, scenario)
    unless specialization_method?(validator, scenario)
      raise Error, "#{validator.name} doesn't have a `#{scenario}' scenario method"
    end
  end

  def specialization_method?(validator, scenario)
    validator.respond_to?(scenario)
  end

  def get_specialization(validator, scenario)
    validator.public_send(scenario)
  end
end
