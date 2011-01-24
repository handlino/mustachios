require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class HasMustacheInstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def create_theme_model
        invoke "active_record:model", ['MustacheTheme'], :migration => false 

        # we need invoke active_record:model again
        @_invocations.delete(ActiveRecord::Generators::ModelGenerator)
        @_invocations.delete(TestUnit::Generators::ModelGenerator)
      end

      def inject_mustache_theme
        inject_into_class("app/models/mustache_theme.rb", MustacheTheme ) do 
        <<eos
  include Mustachios:Renderable
  has_many :images, :class_name => "MustacheThemeImage"
eos
        end
      end

      def create_image_model
        invoke "active_record:model", ['MustacheThemeImage'], :migration => false, :invoice_again => nil
      end

      def inject_mustache_theme_image
        inject_into_file("app/models/mustache_theme_image.rb", :before => "class MustacheThemeImage\n" ) do  
          "require 'carrierwave/orm/active_record'\n"
        end 

        inject_into_class("app/models/mustache_theme_image.rb", MustacheThemeImage ) do 
        <<eos
  belongs_to :mustache_theme
  
  mount_uploader :image, MustacheThemeImageUploader
  
  delegate :url, :to => :image

eos
        end
      end

      def cteate_migration
        migration_template "create_mustache_theme_migration.rb", "db/migrate/create_mustache_theme.rb"
      end

      private
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end # class InstallGenerator
  end # module Generators
end # module ActiveRecord
