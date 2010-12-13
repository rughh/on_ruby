# encoding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.name 'Uschi Müller'
  f.sequence(:nickname){|n| "uschi #{n}"}
  f.image 'http://onruby.de/logo.png'
end
