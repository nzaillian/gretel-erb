Gem::Specification.new do |s|
  s.name = "gretel-erb"
  s.version = "1.0.8"

  s.author = "nzaillian"
  s.email = "nzaillian@gmail.com"
  
  s.description = "EOS This is a significant fork of Lasse Bunk's rails gem 'gretel' (http://github.com/lassebunk/gretel) that retains the convenient page hierarchy specification DSL of the original gem, but does all rendering using a user-specifiable partial template."
  
  s.summary = "Lasse Bunk's 'gretel' (http://github.com/lassebunk/gretel), but with erb templates for breadcrumb rendering!"
  s.homepage = "http://github.com/nzaillian/gretel-erb"
  
  s.files = Dir['lib/**/*.rb']
  s.require_paths = ["lib"]
end