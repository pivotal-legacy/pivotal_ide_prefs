require "ide_prefs/commands/uninstall_prefs"
require "support/mocks/mock_backup_prefs_repo"
require "support/mocks/mock_user_prefs_repo"
require "support/mocks/mock_pivotal_prefs_repo"


module IdePrefs::Commands
  describe UninstallPrefs do
    it "destroys any installed prefs" do
      execute_uninstall

      expect(user_prefs_repo.installed_prefs).to be_empty
    end

    it "restores any backed up prefs" do
      execute_uninstall

      expect(user_prefs_repo.all).to include(*backup_prefs_repo.all)
    end

    let(:user_prefs_repo) { Spec::Support::Mocks::MockUserPrefsRepo.new }
    let(:pivotal_prefs_repo) { Spec::Support::Mocks::MockPivotalPrefsRepo.new(prefs: ["prefs!"]) }
    let(:backup_prefs_repo) { Spec::Support::Mocks::MockBackupPrefsRepo.new(prefs: ["backed up prefs!"]) }

    def execute_uninstall
      UninstallPrefs.new(
        user_prefs_repo: user_prefs_repo,
        pivotal_prefs_repo: pivotal_prefs_repo,
        backup_prefs_repo: backup_prefs_repo,
      ).execute
    end
  end
end
