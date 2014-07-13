require "persistence/repos/pivotal_prefs_repo"

module Persistence::Repos
  describe PivotalPrefsRepo do
    it "returns all preferences put into it" do
      repo = PivotalPrefsRepo.new
      pref = IdePrefs::Entities::Pref.new(id: "some/pref")
      repo.put(pref)
      expect(PivotalPrefsRepo.new(location: repo.location).all).to include pref
    end
  end
end
