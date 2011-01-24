module Mustachios
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "Install MustacheTheme & MustacheThemeImage Model"
      hook_for :orm, :as => :has_mustache_install

      def copy_uploader
        copy_file 'mustache_theme_image_uploader.rb', 'app/uploader/mustache_theme_image_uploader.rb'
      end
    end
  end
end
