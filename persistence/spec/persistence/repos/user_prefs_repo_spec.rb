require "persistence/repos/user_prefs_repo"

module Persistence::Repos
  describe UserPrefsRepo do
    it "finds prefs with matching ids" do
      pref_in_repo = IdePrefs::Entities::Pref.new(id: "1")
      pref_not_in_repo = IdePrefs::Entities::Pref.new(id: "2")

      repo = UserPrefsRepo.new
      repo.put(pref_in_repo)

      matching_prefs = UserPrefsRepo.new(repo.config).find_matching_prefs([pref_in_repo, pref_not_in_repo])

      expect(matching_prefs).to include pref_in_repo
      expect(matching_prefs).not_to include pref_not_in_repo
    end
  end
end
