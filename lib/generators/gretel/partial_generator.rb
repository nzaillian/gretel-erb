module Gretel
  module Generators
    class PartialGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_partial
        copy_file "_gretel_breadcrumb.html.erb", "app/views/common/_gretel_breadcrumb.html.erb"
      end

      def copy_assets
        copy_file "breadcrumb.css.erb", "app/assets/stylesheets/common/breadcrumb.css.erb"
        copy_file "images/breadcrumb_bg.png", "app/assets/images/common/breadcrumb/breadcrumb_bg.png"
        copy_file "images/breadcrumb_separator.png", "app/assets/images/common/breadcrumb/breadcrumb_separator.png"
      end
    end
  end
end