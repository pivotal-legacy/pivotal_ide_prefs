require "persistence/repos/pivotal_prefs_repo"
require "support/fake_repo"

module Persistence::Repos
  describe PivotalPrefsRepo do
    it "returns all preferences put into it" do
      populated_repo = PivotalPrefsRepo.new(location: Spec::Support::FakeRepo.location)
      fresh_repo = PivotalPrefsRepo.new
      pref = populated_repo.all.first

      fresh_repo.copy(pref)

      expect(PivotalPrefsRepo.new(fresh_repo.config).all).to include pref
    end
  end
end
