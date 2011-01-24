module Mustachios
  module Generators
    class MustachiosGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)
      namespace 'mustachios'
      hook_for :orm, :as => :has_mustache_model
      argument :name
    end
  end     
end
