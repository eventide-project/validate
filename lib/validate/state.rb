module Validate
  class State
    def entries
      @entries ||= []
    end

    def entries?
      !entries.empty?
    end

    def each(&action)
      entries.each(&action)
    end

    def push(entry)
      entries.push(entry)
    end
    alias :<< :push
  end
end
