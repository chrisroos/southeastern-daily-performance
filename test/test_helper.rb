# $: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require 'mocha'

require File.join(File.dirname(__FILE__), '..', 'lib', 'sedpr')