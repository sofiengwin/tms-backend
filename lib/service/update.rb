module Service
  class Update < Base
    def perform(record)
      Result.new.tap do |result|
        if valid?
          record.update!(changeset)
          result.succeed(record)
        end
        result.fail(errors)
      end
    end
  end
end