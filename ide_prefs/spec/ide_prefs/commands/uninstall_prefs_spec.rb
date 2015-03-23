require "ide_prefs/commands/uninstall_prefs"
require "support/doubles/fake_backup_prefs_repo"
require "support/doubles/fake_user_prefs_repo"
require "support/doubles/fake_pivotal_prefs_repo"
require "support/fake_pref_factory"


module IdePrefs::Commands
  describe UninstallPrefs do
    context "Given there are installed preferences in the user prefs repo" do
      before do
        @pref = pref_factory.generate_pref
        user_prefs_repo.install_prefs([@pref])
        backup_prefs_repo.back_up_prefs([@pref])
      end

      context "When I uninstall preferences" do
        before do
          UninstallPrefs.new(
            user_prefs_repo: user_prefs_repo,
            pivotal_prefs_repo: pivotal_prefs_repo,
            backup_prefs_repo: backup_prefs_repo,
          ).execute
        end

        specify "Then it should destroy the installed prefs" do
          expect(user_prefs_repo.installed_prefs).not_to include(@pref)
        end

        specify "And it should restore the backed up prefs" do
          expect(user_prefs_repo.uninstalled_prefs).to include(@pref)
        end
      end
    end

    let(:user_prefs_repo) { Spec::Support::Doubles::FakeUserPrefsRepo.new }
    let(:pivotal_prefs_repo) { Spec::Support::Doubles::FakePivotalPrefsRepo.new }
    let(:backup_prefs_repo) { Spec::Support::Doubles::FakeBackupPrefsRepo.new }
    let(:pref_factory) { FakePrefFactory.new }
  end
end
