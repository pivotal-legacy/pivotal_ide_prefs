require "persistence/repos/backup_prefs_repo"
require "persistence/repos/pivotal_prefs_repo"
require "support/fake_repo"

module Persistence::Repos
  describe BackupPrefsRepo do
    it "backs up prefs stored in other repos" do
      pivotal_prefs_repo = PivotalPrefsRepo.new(location: Spec::Support::FakeRepo.location)
      pref = pivotal_prefs_repo.all.first

      repo = BackupPrefsRepo.new
      repo.back_up_prefs([pref])
      expect(BackupPrefsRepo.new(repo.config).all).to include pref
    end
  end
end
