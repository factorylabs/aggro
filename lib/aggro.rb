require "aggro/version"

module Aggro
  class User
    SUPPORTED_SERVICES = [:instagram, :twitter]

    attr_accessor *SUPPORTED_SERVICES

    def initialize(params)
      unless params.keys.any? { |service| SUPPORTED_SERVICES.include?(service) }
        raise ArgumentError, "must specify a supported service: instagram, twitter"
      end

      SUPPORTED_SERVICES.each do |service|
        instance_variable_set("@#{service}", params[service] || "")
      end
    end
  end
end
