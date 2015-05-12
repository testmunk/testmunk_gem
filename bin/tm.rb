#!/usr/bin/env ruby

require 'optparse'
# require 'testmunk/calabash/ios/utils/utils'
require_relative '../lib/testmunk/calabash/ios/utils/utils'

$stderr.sync = true

option = nil
file = nil

# parse arguments
# tm -o install -f file.ipa

ARGV.options do |opts|
  opts.on('-f', '--file=val', '.ipa file', String) { |val| file = val }
  opts.on('-o', '--opt=val', 'Options: resign, install', String) { |val| option = val }
  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end

  opts.parse!
end

case option
  when 'resign'
    Testmunk::IOS::Utils::resign(file, ENV['TM_MOBILE_PROVISION'],
                                 ENV['TM_WILDCARD'],
                                 ENV['TM_IOS_CERTIFICATE'],
                                 ENV['TM_BUNDLE_ID']) if file
  when 'install'
    Testmunk::IOS::Utils::install(file) if file
end