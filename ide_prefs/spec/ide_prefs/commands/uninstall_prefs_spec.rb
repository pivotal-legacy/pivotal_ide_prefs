require "ide_prefs/commands/uninstall_prefs"
require "support/mocks/backup_prefs_repo_spy"
require "support/mocks/user_prefs_repo_spy"
require "support/mocks/pivotal_prefs_repo_stub"


module IdePrefs::Commands
  describe UninstallPrefs do
    it "destroys any installed prefs" do
      execute_uninstall

      expect(user_prefs_repo).to have_destroyed_installed_prefs
    end

    it "restores any backed up prefs" do
      execute_uninstall

      expect(user_prefs_repo).to have_copied(backup_prefs_repo.all)
    end

    let(:user_prefs_repo) { Spec::Support::Mocks::UserPrefsRepoSpy.new }
    let(:pivotal_prefs_repo) { Spec::Support::Mocks::PivotalPrefsRepoStub.new(prefs: "prefs!") }
    let(:backup_prefs_repo) { Spec::Support::Mocks::BackupPrefsRepoSpy.new(prefs: "backed up prefs!") }

    def execute_uninstall
      UninstallPrefs.new(
        user_prefs_repo: user_prefs_repo,
        pivotal_prefs_repo: pivotal_prefs_repo,
        backup_prefs_repo: backup_prefs_repo,
      ).execute
    end
  end
end
