module Validate
  class State
    def entries
      @entries ||= []
    end

    def entries?
      !entries.empty?
    end
  end
end
