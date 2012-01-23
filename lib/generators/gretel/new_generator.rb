module Gretel
  module Generators
    class NewGenerator < Rails::Generators::NamedBase

      # this generator simply runs our two other generators (wrapping what
      # would otherwise be 2 invocations into 1)
      def run_all
        generate("gretel:initializer", file_name)
        generate("gretel:partial")
      end
    end
  end
end