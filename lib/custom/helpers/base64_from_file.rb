# frozen_string_literal: true
module Custom
  module Helpers
    class Base64FromFile
      def self.convert(file)
        content_type = file.content_type
        data = Base64.strict_encode64(file.read)

        "data:#{content_type};base64,#{data}"
      end
    end
  end
end
