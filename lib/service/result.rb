module Service
  class Result < ::Promise
    alias succeed fulfill
    alias fail reject
    alias succeeded? fulfilled?
    alias failed? rejected?

    def self.reject(reason = nil)
      new.tap { |r| r.reject(reason) }
    end

    def self.from(truthy)
      truthy ? resolve(truthy) : reject(truthy)
    end

    def on_success
      yield value if succeeded?
      self
    end

    def on_failure
      yield reason if failed?
      self
    end
  end
end