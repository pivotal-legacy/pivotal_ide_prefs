require "ide_prefs/commands/install_prefs"
require "support/doubles/fake_backup_prefs_repo"
require "support/doubles/fake_user_prefs_repo"
require "support/doubles/fake_pivotal_prefs_repo"
require "support/fake_pref_factory"

module IdePrefs
  module Commands
    describe InstallPrefs do
      context "Given that the pivotal prefs repo includes a pref that already exists in the user prefs repo" do
        before do
          @pref = pref_factory.generate_pref
          pivotal_prefs_repo.copy(@pref)
          user_prefs_repo.copy(@pref)
        end

        context "When I install prefs" do
          before do
            InstallPrefs.new(
              user_prefs_repo: user_prefs_repo,
              pivotal_prefs_repo: pivotal_prefs_repo,
              backup_prefs_repo: backup_prefs_repo,
            ).execute
          end

          specify "Then it backs up the user's existing pref" do
            expect(backup_prefs_repo.all).to include(@pref)
          end

          specify "And it installs the pivotal pref" do
            expect(user_prefs_repo.installed_prefs).to include(@pref)
          end
        end
      end

      let(:user_prefs_repo) { Spec::Support::Doubles::FakeUserPrefsRepo.new }
      let(:backup_prefs_repo) { Spec::Support::Doubles::FakeBackupPrefsRepo.new }
      let(:pivotal_prefs_repo) { Spec::Support::Doubles::FakePivotalPrefsRepo.new }
      let(:pref_factory) { FakePrefFactory.new }
    end
  end
end
