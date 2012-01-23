module Gretel
  class Crumbs
    #holds the path (as a string) for the partial that will be used
    #to render the breadcrumb (should the user set it).
    #note: the template name should be prefixed with an underscore, and the provided path
    #should not include this underscore (in accordance with rails' convention for naming and rendering partials)
    @@template = 'common/gretel_breadcrumb.html.erb' #...the default breadcrumb template
    class << self
      def controller # hack because Rails.application.routes.url_helpers needs a controller method
      end
      
      def layout(&block)
        # needs to be done here because Rails.application isn't set when this file is required
        self.class.send :include, Rails.application.routes.url_helpers
        self.class.send :include, ActionView::Helpers::UrlHelper
        
        instance_eval &block
      end

      #functions both as an accessor for the class' template and also
      #as a setter.  If you want to associate a template with your breadcrumb,
      #we suggest you add a call to this method in the block you pass to the layout method (above)
      #and pass it the path (as a string) to the partial you want used for rendering the breadcrumb.
      def template(*template)
        @@template = template[0] if template.length > 0
        @@template
      end
      
      def all
        @crumbs ||= {}
      end

      def crumb(name, &block)
        all[name] = block
      end
      
      def get_crumb(name, object = nil)
        raise "Crumb '#{name}' not found." unless all[name]
        
        @object = object # share the object so we can call it from link() and parent()
        @link = nil
        @parent = nil
        
        all[name].call(object)
        Gretel::Crumb.new(@link, @parent)
      end
      
      def link(text, url, options = {})
        text = text.call(@object) if text.is_a?(Proc)
        url = url.call(@object) if url.is_a?(Proc)
        
        @link = Gretel::Link.new(text, url, options)
      end
      
      def parent(name, object = nil)
        name = name.call(@object) if name.is_a?(Proc)
        object = object.call(@object) if object.is_a?(Proc)

        @parent = Gretel::Parent.new(name, object)
      end
    end
  end
end