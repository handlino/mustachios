# HasMustache
require "mustache"

module Mustachios
  def self.included (base)
    base.extend(ClassMethods)
  end 

  module ClassMethods
    def has_mustache_theme(name='theme', options={})

      options = { 
        :theme => "#{self.to_s.underscore}_theme",
        :theme_style => nil,
        :data => nil
      }.merge(options)
       
      define_method( name.to_sym ) do 
        theme = self.send(options[:theme])
        data = options[:data] ? self.send(options[:data]) : self 
        if theme.is_a? String
          Mustache.render( theme, data) 
        else
          theme.send( :render_html, data)
        end
      end 

      define_method( "#{name}_style".to_sym ) do 
        theme = options[:theme_style] ? self.send(options[:theme_style]) : self.send(options[:theme])
        data = options[:data] ? self.send(options[:data]) : self 
        if theme.is_a? String
          Mustache.render( theme, data) 
        else
          theme.send( :render_css, data)
        end
      end
    end 
  end 

end

module Mustachios
  module Renderable

    def render_html(data)
      Mustache.render(self.html, self.filter_data(data) )
    end
    
    def render_css(data)
      Mustache.render(self.css, self.filter_data(data) )
    end

    protected
    def filter_data(data)
      data
    end
  end
end
