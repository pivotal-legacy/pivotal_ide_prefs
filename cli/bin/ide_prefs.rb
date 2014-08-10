#!/usr/bin/env ruby

$LOAD_PATH.unshift "../ide_prefs/lib"
$LOAD_PATH.unshift "../persistence/lib"
$LOAD_PATH.unshift "../logging/lib"
$LOAD_PATH.unshift "lib"

require "optparse"
require "ide_prefs"
require "persistence"
require "cli"

repo_config_options = {}
logging_options = {log_level: :info}

OptionParser.new do |opts|
  opts.on("--ide=IDE") do |ide|
    repo_config_options[:user_prefs_repo_location] = Module.const_get("Cli::Ide::#{ide.capitalize}").new.user_prefs_repo_location
    repo_config_options[:ide_name] = ide
  end

  opts.on("--user-prefs-location=PATH") do |location|
    repo_config_options[:user_prefs_repo_location] = location
  end

  opts.on("--backup-prefs-location=PATH") do |location|
    repo_config_options[:backup_prefs_repo_location] = location
  end

  opts.on("--log-level=LEVEL", [:info, :debug, :silent]) do |level|
    logging_options[:log_level] = level
  end
end.parse!

if repo_config_options[:ide_name].nil?
  puts "You must specify an IDE with the --ide switch. Use the `--help` switch for more information."
  exit 1
end

Cli::Logger.new(log_level: logging_options[:log_level]).start

repo_configuration = Cli::Configuration::RepoConfiguration.new(repo_config_options)

repos = {
  user_prefs_repo:    Persistence::Repos::UserPrefsRepo.new(location: repo_configuration.user_prefs_repo_location),
  backup_prefs_repo:  Persistence::Repos::BackupPrefsRepo.new(location: repo_configuration.backup_prefs_repo_location),
  pivotal_prefs_repo: Persistence::Repos::PivotalPrefsRepo.new(location: repo_configuration.pivotal_prefs_repo_location),
}

Cli::CommandFactory.new(ARGV.last).command.new(repos).execute
