lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/docker/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-docker'
  spec.version       = Capistrano::Docker::VERSION
  spec.authors       = ['MickPlaYer']
  spec.email         = ['mickgamehome@gmail.com']

  spec.summary       = 'Deploy your rails into docker.'
  spec.description   = 'Mount linked dirs and files to volumn ' \
                       'and pass command to container.'
  spec.homepage      = 'https://github.com/MickPlaYer/capistrano-docker'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |file|
      file.match(%r{^(test|spec|features)/})
    end
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.58.1'
end
