require "ide_prefs/commands/install_prefs"
require "support/doubles/fake_backup_prefs_repo"
require "support/doubles/fake_user_prefs_repo"
require "support/doubles/fake_pivotal_prefs_repo"

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
      let(:user_prefs_repo) { Spec::Support::Doubles::FakeUserPrefsRepo.new(matching_uninstalled_prefs: matching_uninstalled_prefs) }
      let(:backup_prefs_repo) { Spec::Support::Doubles::FakeBackupPrefsRepo.new }
      let(:pivotal_prefs_repo) { Spec::Support::Doubles::FakePivotalPrefsRepo.new(prefs: ["a pref"]) }
    end
  end
end
