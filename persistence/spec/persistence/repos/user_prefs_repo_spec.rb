require "persistence/repos/user_prefs_repo"
require "persistence/repos/pivotal_prefs_repo"
require "support/fake_repo"

module Persistence::Repos
  describe UserPrefsRepo do
    it "copies prefs into the repo" do
      pref = pivotal_prefs_repo.all.first
      user_prefs_repo.copy(pref)

      expect(user_prefs_repo.all.first.contents).to eq pref.contents
      expect(pref.contents).not_to be_nil
    end


    it "finds uninstalled prefs with matching ids" do
      pref_in_repo = pivotal_prefs_repo.all.first
      pref_for_install = pivotal_prefs_repo.all.last

      user_prefs_repo.copy(pref_in_repo)
      user_prefs_repo.install_prefs([pref_for_install])

      matching_prefs = user_prefs_repo.find_matching_uninstalled_prefs([pref_in_repo, pref_for_install])
      expect(matching_prefs).to include pref_in_repo
      expect(matching_prefs).not_to include pref_for_install
    end

    it "installs prefs" do
      pref = pivotal_prefs_repo.all.first
      user_prefs_repo.install_prefs([pref])

      expect(user_prefs_repo.all).to include pref
      expect(user_prefs_repo.installed_prefs).to include pref
    end

    it "does not break if you attempt to install the same pref twice" do
      pivotal_pref = pivotal_prefs_repo.all.first

      expect {
        user_prefs_repo.install_prefs([pivotal_pref])
        user_prefs_repo.install_prefs([pivotal_pref])
      }.not_to raise_exception
    end

    let(:pivotal_prefs_repo) { PivotalPrefsRepo.new(location: Spec::Support::FakeRepo.location) }
    let(:user_prefs_repo) { UserPrefsRepo.new }
  end
end
