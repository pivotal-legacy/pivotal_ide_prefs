require "support/doubles/fake_user_prefs_repo"
require "support/fake_pref_factory"
require "ide_prefs_test_support/contracts/user_prefs_repo_contract"

assert_works_like_user_prefs_repo(
  pref_factory: FakePrefFactory.new,
  user_prefs_repo_factory: -> { Spec::Support::Doubles::FakeUserPrefsRepo.new }
)
