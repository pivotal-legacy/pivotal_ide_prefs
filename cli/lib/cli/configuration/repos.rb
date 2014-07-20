module Cli
  module Configuration
    def self.Repos(locations)
      {
        user_prefs_repo: Persistence::Repos::UserPrefsRepo.new(location: locations[:user_prefs_repo]),
        backup_prefs_repo: Persistence::Repos::BackupPrefsRepo.new(location: locations[:backup_prefs_repo] || File.expand_path(File.join("~", ".pivotal_ide_prefs", "backups", File.basename(locations[:user_prefs_repo])))),
        pivotal_prefs_repo: Persistence::Repos::PivotalPrefsRepo.new(location: locations[:pivotal_prefs_repo]),
      }
    end
  end
end
