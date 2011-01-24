require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class HasMustacheModelGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      argument :name

      def create_theme_model
        invoke "active_record:model", [name], :parent => 'mustache_theme'
      end

    end # class InstallGenerator
  end # module Generators
end # module Mongoid
