require 'rails/generators/mongoid_generator'

module Mongoid
  module Generators
    class HasMustacheModelGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :name

      def create_theme_model
        invoke "mongoid:model", [name], :parent => 'mustache_theme'
      end

    end # class InstallGenerator
  end # module Generators
end # module Mongoid
