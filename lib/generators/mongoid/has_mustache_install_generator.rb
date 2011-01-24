require 'rails/generators/mongoid_generator'

module Mongoid
  module Generators
    class HasMustacheInstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def create_theme_model
        invoke "mongoid:model", ['MustacheTheme'], :migration => false, :timestamps => true
        # we need invoke active_record:model again
        @_invocations.delete(Mongoid::Generators::ModelGenerator)

        inject_into_file("app/models/mustache_theme.rb",  :after => "include Mongoid::Timestamps\n") do 
        <<eos
  include Mustachios::Renderable
  embeds_many :images, :class_name => 'MustacheThemeImage'

  field :type
  field :name
  field :desctiption
  field :html
  field :css
eos
        end
      end

      def create_image_model
        invoke "mongoid:model", ['MustacheThemeImage'], :migration => false, :timestamps => true
        
        inject_into_file("app/models/mustache_theme_image.rb", :before => "class MustacheThemeImage\n" ) do 
        "require 'carrierwave/orm/mongoid'\n"
        end

        inject_into_file("app/models/mustache_theme_image.rb", :after => "include Mongoid::Timestamps\n" ) do 
        <<eos
  field :type
  
  embedded_in :mustache_theme, :inverse_of => :images
  
  mount_uploader :image, MustacheThemeImageUploader
  
  delegate :url, :to => :image
eos
        end
      end

    end # class InstallGenerator
  end # module Generators
end # module Mongoid
