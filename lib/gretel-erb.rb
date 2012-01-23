require 'gretel-erb/crumb'
require 'gretel-erb/crumbs'
require 'gretel-erb/helper_methods'
require 'gretel-erb/link'
require 'gretel-erb/parent'

ActionController::Base.send :include, Gretel::HelperMethods