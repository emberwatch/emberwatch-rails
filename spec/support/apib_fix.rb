module RSpec
  module Apib
    class Recorder
      def path
        @path ||= begin
          parts = route.parts
          tmp = {}
          parts.each do |part|
            if route.respond_to?(:optional_parts)
              if route.optional_parts.include?(part)
                tmp[part] = "(:#{part}:)"
              else
                tmp[part] = ":#{part}:"
              end
            elsif route.respond_to?(:required_parts)
              if route.required_parts.include?(part)
                tmp[part] = ":#{part}:"
              else
                tmp[part] = "(:#{part}:)"
              end
            end
          end
          result = route.format(tmp).gsub(/:(.*?):/, '{\\1}')
          result = result.gsub('.(', '(.')
          result = result.gsub('/(', '(/')
          result
        end
      end
    end
  end
end
