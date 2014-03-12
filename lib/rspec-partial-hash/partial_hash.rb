require 'active_support/core_ext/hash/slice'

PartialHashMatcher = Class.new {
  def self.partial_match?(expected, actual)
    actual_slice = actual.slice(*expected.keys)
    if actual_slice.keys == expected.keys
      actual_slice.each do |key, value|
        if value.respond_to?(:to_h) or value.is_a?(Hash)
          return partial_match?(expected[key], value)
        else
          return false unless value == expected[key]
        end
      end
      true
    else
      false
    end
  end
}

RSpec::Matchers.define :include_partial_hash do |expected|

  match do |actual|
    raise ArgumentError, "Expectation not a hash" unless
      expected.respond_to?(:to_h) or expected.is_a?(Hash)
    !actual.nil? && !expected.nil? && PartialHashMatcher.partial_match?(expected, actual)
  end

end