require "ide_prefs_test_support/contracts/basic_prefs_repo_contract"

def assert_works_like_pivotal_prefs_repo(pref_factory: nil, pivotal_prefs_repo_factory: nil)
  assert_works_like_basic_prefs_repo(
    pref_factory: pref_factory,
    prefs_repo_factory: pivotal_prefs_repo_factory,
  )
end
