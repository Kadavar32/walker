module StructureWalker
  class Stepper
    class << self
      def invoke(step)
        steps_module = StructureWalker::Steps
        steps = steps_module.constants.grep(/STEP/).map { |e| steps_module.const_get e }.to_h
        steps[step]
      end
    end
  end
end