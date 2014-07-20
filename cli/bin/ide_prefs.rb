#!/usr/bin/env ruby

require "optparse"

$LOAD_PATH.unshift "../ide_prefs/lib"
$LOAD_PATH.unshift "../persistence/lib"
$LOAD_PATH.unshift "../log/lib"
$LOAD_PATH.unshift "lib"

require "ide_prefs"
require "persistence"
require "cli/logging"

options = {}

OptionParser.new do |opts|
  opts.on("--ide IDE") do |ide|
    case ide.downcase
    when "rubymine"
      options[:user_prefs_repo]    = Persistence::Repos::UserPrefsRepo.new(location: File.expand_path(File.join("~", "Library", "Preferences", "RubyMine60")))
      options[:backup_prefs_repo]  = Persistence::Repos::BackupPrefsRepo.new(location: File.expand_path(File.join("~", ".pivotal_ide_prefs", "backups", "RubyMine60")))
      options[:pivotal_prefs_repo] = Persistence::Repos::PivotalPrefsRepo.new(location: File.expand_path(File.join(__dir__, "..", "..", "pref_sources", "RubyMine")))
    else
      raise "Unknown IDE"
    end
  end

  opts.on("--user-prefs-location=PATH") do |location|
    options[:user_prefs_repo] = Persistence::Repos::UserPrefsRepo.new(location: location)
  end

  opts.on("--backup-prefs-location=PATH") do |location|
    options[:backup_prefs_repo] = Persistence::Repos::BackupPrefsRepo.new(location: location)
  end
end.parse!

if options[:pivotal_prefs_repo].nil?
  puts "You must specify an IDE. Run `ide_prefs --help` for more information."
  exit 1
end

command = nil

case ARGV.last
  when "install"
    command = IdePrefs::Commands::InstallPrefs.new options
  when "uninstall"
    command = IdePrefs::Commands::UninstallPrefs.new options
  else
    puts "Unknown command."
    exit 1
end

command.execute
