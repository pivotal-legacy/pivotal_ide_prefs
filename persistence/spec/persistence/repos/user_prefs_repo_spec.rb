require "persistence/repos/user_prefs_repo"
require "persistence/repos/pivotal_prefs_repo"

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

    it "installs prefs" do
      pivotal_prefs_repo = PivotalPrefsRepo.new
      pivotal_prefs_repo.put(IdePrefs::Entities::Pref.new(id: "1"))

      pref = pivotal_prefs_repo.all.first

      repo = UserPrefsRepo.new

      repo.install_prefs([pref])

      expect(repo.all).to include pref
      expect(repo.installed_prefs).to include pref
    end

    it "does not break if you attempt to install the same pref twice" do
      pivotal_prefs_repo = PivotalPrefsRepo.new
      pivotal_prefs_repo.put(IdePrefs::Entities::Pref.new(id: "1"))

      pivotal_pref = pivotal_prefs_repo.all.first

      user_prefs_repo = UserPrefsRepo.new

      expect {
        user_prefs_repo.install_prefs([pivotal_pref])
        user_prefs_repo.install_prefs([pivotal_pref])
      }.not_to raise_exception
    end
  end
end
