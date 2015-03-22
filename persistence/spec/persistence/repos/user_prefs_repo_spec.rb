require "persistence/repos/user_prefs_repo"
require "ide_prefs_test_support/contracts/user_prefs_repo_contract"
require "support/pref_factory"

assert_works_like_user_prefs_repo(
  pref_factory: PrefFactory.new,
  user_prefs_repo_factory: -> { Persistence::Repos::UserPrefsRepo.new },
)
