$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "double_dice/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "double_dice"
  s.version     = DoubeDice::VERSION
  s.authors     = ["Carsten Zimmermann"]
  s.email       = ["cz@aegisnet.de"]
  s.homepage    = "https://github.com/carpodaster/double_dice"
  s.summary     = "Ruby interface for the 'Double Dice' encryption algorithm"
  s.description = "Ruby interface for the 'Double Dice' encryption algorithm"
  s.license     = "ISC/BSD-style"

  s.files = Dir["{lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
end
