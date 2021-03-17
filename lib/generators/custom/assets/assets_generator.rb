require "rails/generators/named_base"

module Custom
  module Generators
    class AssetsGenerator < ::Rails::Generators::NamedBase
      source_root File.join(Rails.root, 'lib', 'templates', 'coffee', File::SEPARATOR)

      def copy_coffee
        template "javascript.coffee", File.join('app/assets/javascripts', class_path, "#{file_name}.coffee")
      end
    end
  end
end
