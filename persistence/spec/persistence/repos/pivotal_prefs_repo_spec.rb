require "persistence/repos/pivotal_prefs_repo"
require "ide_prefs_test_support/contracts/pivotal_prefs_repo_contract"
require "support/pref_factory"

assert_works_like_pivotal_prefs_repo(
  pref_factory: PrefFactory.new,
  pivotal_prefs_repo_factory: -> { Persistence::Repos::PivotalPrefsRepo.new },
)
