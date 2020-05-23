ServiceError = Struct.new(:field, :code)

class ServiceError
  def self.from(errors)
    raise(errors) if errors.is_a?(StandardError)

    errors.details.flat_map do |k, vs|
      vs.map { |v| ServiceError.new(k, v[:error]) }
    end
  end
end