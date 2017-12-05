# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'sti_deploy'
  s.version     = VERSION
  s.authors     = ['Rodrigo Castro Azevedo']
  s.email       = ['rod.c.azevedo@gmail.com']
  s.homepage    = 'https://github.com/roooodcastro/sti_deploy'
  s.license     = 'MIT'
  s.summary     = 'A small program to make commits and merges faster.'
  s.description = 'A small program to make commits and merges faster. This ' \
                  'program automagically bumps the version number, commits ' \
                  'to the working branch, merges to the deploy branch, ' \
                  'and creates a release tag.'

  s.files = Dir['{bin,lang,lib}/**/*'] +
    ['LICENSE', 'README.md']

  s.add_runtime_dependency 'colorize', '~> 0'
  s.add_runtime_dependency 'i18n', '~> 0'

  s.add_development_dependency 'awesome_print', '~> 0'
  s.add_development_dependency 'pry', '~> 0'
  s.add_development_dependency 'rubocop', '~> 0'
end
