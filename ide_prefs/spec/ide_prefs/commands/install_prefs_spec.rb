require "ide_prefs/commands/install_prefs"
require "support/mocks/mock_backup_prefs_repo"
require "support/mocks/mock_user_prefs_repo"
require "support/mocks/mock_pivotal_prefs_repo"

module IdePrefs
  module Commands
    describe InstallPrefs do
      context "there are matching prefs already in the user prefs repo" do
        let(:matching_uninstalled_prefs) { ["a fake matching pref!"] }

        it "backs up matching user prefs" do
          execute

          expect(backup_prefs_repo.all).to include(*matching_uninstalled_prefs)
        end
      end

      it "installs the source prefs" do
        execute

        expect(user_prefs_repo.installed_prefs).to include(*pivotal_prefs_repo.all)
      end

      def execute
        InstallPrefs.new(
          user_prefs_repo: user_prefs_repo,
          pivotal_prefs_repo: pivotal_prefs_repo,
          backup_prefs_repo: backup_prefs_repo,
        ).execute
      end

      let(:matching_uninstalled_prefs) { [] }
      let(:user_prefs_repo) { Spec::Support::Mocks::MockUserPrefsRepo.new(matching_uninstalled_prefs: matching_uninstalled_prefs) }
      let(:backup_prefs_repo) { Spec::Support::Mocks::MockBackupPrefsRepo.new }
      let(:pivotal_prefs_repo) { Spec::Support::Mocks::MockPivotalPrefsRepo.new(prefs: ["a pref"]) }
    end
  end
end
