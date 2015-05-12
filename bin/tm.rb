#!/usr/bin/env ruby

require 'optparse'
require 'yaml'
# require 'testmunk/calabash/ios/utils/utils'
require_relative '../lib/testmunk/calabash/ios/utils/utils'

$stderr.sync = true

option = nil
app = nil
device = nil
feature_file = nil

# parse arguments
# tm -o install -f file.ipa

ARGV.options do |opts|
  opts.on('-a', '--app=val', '.ipa file', String) { |val| app = val }
  opts.on('-f', '--feature-file=val', '.feature file', String) { |val| feature_file = val }
  opts.on('-o', '--opt=val', 'Options: resign, install', String) { |val| option = val }
  opts.on('-d', '--device=val', 'Device', String) { |val| device = val }

  opts.on('-h', '--help', 'Displays Help') do
    puts opts
    exit
  end

  opts.parse!
end

case option
  when 'resign'
    Testmunk::IOS::Utils::resign(app, ENV['TM_MOBILE_PROVISION'],
                                 ENV['TM_WILDCARD'],
                                 ENV['TM_IOS_CERTIFICATE'],
                                 ENV['TM_BUNDLE_ID']) if app
  when 'install'
    Testmunk::IOS::Utils::install(app) if app
  when 'run'
    config = YAML.load_file("#{Dir.pwd}/.tm.yaml")
    uuid = config['run']['devices'][device]['uuid']
    endpoint = config['run']['devices'][device]['endpoint']
    bundle_id = config['run']['bundle_id']
    bundle_path = config['run']['bundle_path']

    Testmunk::IOS::Utils::run(uuid, endpoint, bundle_id, bundle_path, feature_file)
end