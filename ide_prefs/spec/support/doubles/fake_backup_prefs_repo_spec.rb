require "support/doubles/fake_backup_prefs_repo"
require "support/fake_pref_factory"
require "ide_prefs_test_support/contracts/backup_prefs_repo_contract"

assert_works_like_a_backup_prefs_repo(
  pref_factory: FakePrefFactory.new,
  backup_prefs_repo_factory: -> { Spec::Support::Doubles::FakeBackupPrefsRepo.new }
)
