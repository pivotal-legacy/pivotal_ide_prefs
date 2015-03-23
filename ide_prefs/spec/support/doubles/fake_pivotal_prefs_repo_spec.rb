require "support/doubles/fake_pivotal_prefs_repo"
require "support/fake_pref_factory"
require "ide_prefs_test_support/contracts/pivotal_prefs_repo_contract"

assert_works_like_pivotal_prefs_repo(
  pref_factory: FakePrefFactory.new,
  pivotal_prefs_repo_factory: -> { Spec::Support::Doubles::FakePivotalPrefsRepo.new }
)
