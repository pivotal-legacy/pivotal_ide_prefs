#!/usr/bin/env ruby

require "optparse"

$LOAD_PATH.unshift "../ide_prefs/lib"
$LOAD_PATH.unshift "../persistence/lib"
$LOAD_PATH.unshift "../log/lib"
$LOAD_PATH.unshift "lib"

require "ide_prefs"
require "persistence"
require "cli"

options = {}

OptionParser.new do |opts|
  opts.on("--ide=IDE") do |ide|
    options[:user_prefs_repo_location] = Module.const_get("Cli::Ide::#{ide.capitalize}").new.user_prefs_repo_location
    options[:ide_name] = ide
  end

  opts.on("--user-prefs-location=PATH") do |location|
    options[:user_prefs_repo_location] = location
  end


  opts.on("--backup-prefs-location=PATH") do |location|
    options[:backup_prefs_repo_location] = location
  end
end.parse!

if options[:ide_name].nil?
  puts "You must specify an IDE with the --ide switch. Use the `--help` switch for more information."
  exit 1
end

repo_configuration = Cli::Configuration::RepoConfiguration.new(options)

repos = {
  user_prefs_repo:    Persistence::Repos::UserPrefsRepo.new(location: repo_configuration.user_prefs_repo_location),
  backup_prefs_repo:  Persistence::Repos::BackupPrefsRepo.new(location: repo_configuration.backup_prefs_repo_location),
  pivotal_prefs_repo: Persistence::Repos::PivotalPrefsRepo.new(location: repo_configuration.pivotal_prefs_repo_location),
}

Cli::CommandFactory.new(ARGV.last).command.new(repos).execute
