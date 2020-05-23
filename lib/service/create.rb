module Service
  class Create < Base
    def perform(klass)
      Result.new.tap do |result|
        if valid?
          record = klass.create!(changeset)
          result.succeed(record)
        end
        result.fail(errors)
      end
    end
  end
end