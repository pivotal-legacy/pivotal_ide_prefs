#!/usr/bin/env ruby

require "optparse"

$LOAD_PATH.unshift "../ide_prefs/lib"
$LOAD_PATH.unshift "../persistence/lib"
$LOAD_PATH.unshift "../log/lib"
$LOAD_PATH.unshift "lib"

require "ide_prefs"
require "persistence"
require "cli"

locations = {}

OptionParser.new do |opts|
  opts.on("--ide IDE") do |ide|
    locations.merge! Module.const_get("Cli::Ide::#{ide.capitalize}").new.locations
  end

  opts.on("--user-prefs-location=PATH") do |location|
    locations[:user_prefs_repo] = location
  end

  opts.on("--backup-prefs-location=PATH") do |location|
    locations[:backup_prefs_repo] = location
  end
end.parse!

if locations[:pivotal_prefs_repo].nil?
  puts "You must specify an IDE. Run `ide_prefs --help` for more information."
  exit 1
end

command = nil

repos = Cli::Configuration::Repos(locations)

case ARGV.last
  when "install"
    command = IdePrefs::Commands::InstallPrefs.new repos
  when "uninstall"
    command = IdePrefs::Commands::UninstallPrefs.new repos
  else
    puts "Unknown command."
    exit 1
end

command.execute
