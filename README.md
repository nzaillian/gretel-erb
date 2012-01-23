Gretel-ERB
==========

Gretel-ERB is a a fork of [Lasse Bunk's 'gretel'](http://github.com/lassebunk/gretel)
that gives you much more control of your breadcrumb's layout by using ERB
templates for rendering.  This fork was authored by [Nicholas Zaillian](http://nicholas.zaillian.com)
([Washington Square Interactive](http://washingtonsquareinteractive.com)) to resolve 
issues encountered during the ongoing development of [GoodTix](http://goodtix.org).

Note: this is a significant fork of gretel and usage is, accordingly, different
from that of the original gem.  Most of the 'breadcrumb' method options from the
original plugin (such as the :pretext and :separator options) are not relevant when
you're using a template to specify the layout of your breadcrumb.  We'll attempt to keep 
version numbers in sync with those of the original project.

Installation
------------

In your <em>Gemfile</em>:

    gem 'gretel-erb', :git => 'git@github.com:nzaillian/gretel-erb.git'

And run:
 
    bundle install

Example
-------

Start by generating the initializer, (default) partial, and assets:

    $ rails generate gretel:all breadcrumbs

This creates the following files:

    config/initializers/breadcrumbs.rb
    app/views/common/_gretel_breadcrumb.html.erb
    app/assets/stylesheets/common/breadcrumb.css.erb
    app/assets/images/common/breadcrumb/breadcrumb_separator.png
    app/assets/images/common/breadcrumb/breadcrumb_bg.png

You'll need to link the stylesheet in the header of the layout for any pages where
you want to display the breadcrumb (assuming you want it styled -- and you almost
certainly do).  You can do that either by including a <pre>stylesheet\_link\_tag('common/breadcrumb')</pre>
directly to the header or adding <pre>*= require './common/breadcrumb'</pre> (or appropriate relative path)
to an asset manifest file that you've linked to.

Finally, use Gretel's DSL (nearly unchanged in this fork) to declare your page hierarchies in
<code>config/initializers/breadcrumbs.rb</code> and template partial path:

    Gretel::Crumbs.layout do
		
      # Declare the path to your custom breadcrumb partial template (optional;
	  # defaults to the path below...)
      template 'common/gretel_breadcrumb.html.erb'

      crumb :root do
        link "Home", root_path
      end

      crumb :projects do
        link "Projects", projects_path, :class => "breadcrumb", :style => "font-weight: bold;"
        link "Projects", projects_path, { :class => 'breadcrumb', :style => 'font-weight: bold;' }
      end

      crumb :project do |project|
        link lambda { |project| "#{project.name} (#{project.id.to_s})" }, project_path(project)
        parent :projects
      end

      crumb :project_issues do |project|
        link "Issues", project_issues_path(project)
        parent :project, project
      end

      crumb :issue do |issue|
        link issue.name, issue_path(issue)
        parent :project_issues, issue.project
      end
    end


In <code>app/views/xx/xx.html.erb</code>:

    <% breadcrumb :issue, @issue %>

options for <code><%= breadcrumb %></code>:

    :autoroot           Whether it should automatically link to :root if no root parent is given. Default: false  
    :show_root_alone  Whether it should show :root if this is the only link. Default: false  
    :link_last          Whether the last crumb should be linked to. Default: false  

The [original Gretel gem](http://github.com/lassebunk/gretel) was written by Lasse Bunk and released under the MIT license.  This gem retains that license.