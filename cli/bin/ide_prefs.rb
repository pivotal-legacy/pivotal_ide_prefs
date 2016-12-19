#!/usr/bin/env ruby

unless RUBY_VERSION.to_i >= 2
  puts "You must use ruby 2.0.0 or greater. OS X Mavericks and beyond ship with Ruby 2+ as the system ruby."
  exit 1
end

bin_dir = File.dirname(__FILE__)
root_dir = File.join(bin_dir, '..', '..')

$LOAD_PATH.unshift "#{root_dir}/ide_prefs/lib"
$LOAD_PATH.unshift "#{root_dir}/persistence/lib"
$LOAD_PATH.unshift "#{root_dir}/logging/lib"
$LOAD_PATH.unshift "#{root_dir}/cli/lib"

require "optparse"
require "ide_prefs"
require "persistence"
require "cli"

repo_config_options = {}
logging_options = {log_level: :info}

OptionParser.new do |opts|
  opts.banner = "Usage: ide_prefs [options] [install,uninstall]"

  opts.on(
      "--ide=IDE",
      ["webstorm", "intellij", "intellijcommunity", "rubymine", "appcode", "androidstudio", "clion", "pycharm"],
      "webstorm, intellij, intellijcommunity, rubymine, appcode, androidstudio", "clion", "pycharm"
  ) do |ide|
    repo_config_options[:user_prefs_repo_location] = Module.const_get("Cli::Ide::#{ide.capitalize}UserPrefDir").new.path
    repo_config_options[:ide_name] = ide
  end

  opts.on("--user-prefs-location=PATH") do |location|
    repo_config_options[:user_prefs_repo_location] = location
  end

  opts.on("--backup-prefs-location=PATH") do |location|
    repo_config_options[:backup_prefs_repo_location] = location
  end

  opts.on("--log-level=LEVEL", ["INFO", "DEBUG", "FATAL"], "INFO, DEBUG, or FATAL") do |level|
    logging_options[:log_level] = level
  end
end.parse!

if repo_config_options[:ide_name].nil?
  puts "You must specify an IDE with the --ide switch. Use the `--help` switch for more information."
  exit 1
end

Cli::Logger.new(log_level: logging_options[:log_level]).start

repo_configuration = Cli::Configuration::RepoConfiguration.new(repo_config_options)

puts "This will install preferences at #{repo_configuration.user_prefs_repo_location}"
puts "And store backups at #{repo_configuration.backup_prefs_repo_location}"

repos = {
  user_prefs_repo:    Persistence::Repos::UserPrefsRepo.new(location: repo_configuration.user_prefs_repo_location),
  backup_prefs_repo:  Persistence::Repos::BackupPrefsRepo.new(location: repo_configuration.backup_prefs_repo_location),
  pivotal_prefs_repo: Persistence::Repos::PivotalPrefsRepo.new(location: repo_configuration.pivotal_prefs_repo_location),
}

Cli::CommandFactory.new(ARGV.last).command.new(repos).execute
