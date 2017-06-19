require 'structure_walker/version'
require 'structure_walker/stepper'
require 'structure_walker/steps'

module StructureWalker
  class Builder
    class << self
      def invoke(proc)
        walker = ->(steps, data) do
          return if data.nil?

          if steps.empty?
            result = proc.call(data)
          else
            steps = steps.clone
            step = steps.shift
            type, keys = step.is_a?(Array) ? [step.first, step.last] : [step, nil]
            result = StructureWalker::Stepper.invoke(type).call(data, steps, walker, keys)
          end
          result
        end

        walker
      end
    end
  end
end
