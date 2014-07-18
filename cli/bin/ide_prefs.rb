#!/usr/bin/env ruby

require "optparse"

$LOAD_PATH.unshift "../ide_prefs/lib"
$LOAD_PATH.unshift "../persistence/lib"

require "ide_prefs"
require "persistence"

options = {
  user_prefs_repo: Persistence::Repos::UserPrefsRepo.new,
  pivotal_prefs_repo: Persistence::Repos::PivotalPrefsRepo.new,
  backup_prefs_repo: Persistence::Repos::BackupPrefsRepo.new,
}

OptionParser.new do |opts|
  opts.on("--ide IDE") do |ide|
    case ide.downcase
    when "rubymine"
      rubymine_source = File.expand_path(File.join(__dir__, "..", "..", "pref_sources", "RubyMineXX"))
      options[:pivotal_prefs_repo] = Persistence::Repos::PivotalPrefsRepo.new(location: rubymine_source)
    else
      raise "Unkown IDE"
    end
  end

  opts.on("--user-prefs-location L") do |location|
    options[:user_prefs_repo] = Persistence::Repos::UserPrefsRepo.new(location: location)
  end
end.parse!

case ARGV.last
  when "install"
    command = IdePrefs::Commands::InstallPrefs.new(
      user_prefs_repo: options[:user_prefs_repo],
      pivotal_prefs_repo: options[:pivotal_prefs_repo],
      backup_prefs_repo: options[:backup_prefs_repo],
    )
  when "uninstall"
    command = IdePrefs::Commands::UninstallPrefs.new(
      user_prefs_repo: options[:user_prefs_repo],
      pivotal_prefs_repo: options[:pivotal_prefs_repo],
      backup_prefs_repo: options[:backup_prefs_repo],
    )
end

command.execute
