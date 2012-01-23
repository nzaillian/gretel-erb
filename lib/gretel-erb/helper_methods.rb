module Gretel
  module HelperMethods
    include ActionView::Helpers::UrlHelper
    def controller # hack because ActionView::Helpers::UrlHelper needs a controller method
    end

    def self.included(base)
      base.send :helper_method, :breadcrumb_for, :breadcrumb
    end

    def breadcrumb(*args)
        options = args.extract_options!
        name, object = args[0], args[1]

        options[:link_last] ||= false

        if name
          @_breadcrumb_name = name
          @_breadcrumb_object = object
          crumbs = breadcrumb_for(@_breadcrumb_name, @_breadcrumb_object, options)
        else
          if @_breadcrumb_name
            crumbs = breadcrumb_for(@_breadcrumb_name, @_breadcrumb_object, options)
          elsif options[:show_root_alone]
            crumbs = breadcrumb_for(:root, options)
          end
        end
        render_to_string(:partial => Crumbs.template, :locals => {:crumbs => crumbs.reverse, :options => options }, :layout => false).html_safe
    end

    def breadcrumb_for(*args)
      options = args.extract_options!

      name, object = args[0], args[1]

      crumb = Crumbs.get_crumb(name, object)
      out = [crumb]

      while parent = crumb.parent
        last_parent = parent.name
        crumb = Crumbs.get_crumb(parent.name, parent.object)
        out << crumb
      end

      # TODO: Refactor this
      if options[:autoroot] && name != :root && last_parent != :root
        crumb = Crumbs.get_crumb(:root)
        out << crumb
      end
      out
    end
  end
end