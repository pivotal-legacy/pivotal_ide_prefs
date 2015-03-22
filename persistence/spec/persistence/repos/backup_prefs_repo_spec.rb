require "persistence/repos/backup_prefs_repo"
require "support/pref_factory"
require "ide_prefs_test_support/contracts/backup_prefs_repo_contract"

assert_works_like_a_backup_prefs_repo(
  pref_factory: PrefFactory.new,
  backup_prefs_repo_factory: -> { Persistence::Repos::BackupPrefsRepo.new },
)
