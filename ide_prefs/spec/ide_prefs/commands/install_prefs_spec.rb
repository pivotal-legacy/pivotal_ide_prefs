require "ide_prefs/commands/install_prefs"

module IdePrefs
  module Commands
    describe InstallPrefs do
      context "the user has not already installed the preferences" do
        before do
          def user_prefs_repo.installed?(*)
            false
          end
        end

        context "there are matching prefs already in the user prefs repo" do
          let(:matching_prefs) { ["a fake matching pref!"] }

          it "backs up matching user prefs" do
            execute

            expect(backup_prefs_repo).to have_backed_up_prefs(matching_prefs)
          end
        end

        it "installs the source prefs" do
          execute

          expect(user_prefs_repo).to have_installed_prefs(pivotal_prefs_repo.all)
        end
      end

      context "the source repository has preferences that are already installed" do
      end

      def execute
        InstallPrefs.new(
          user_prefs_repo: user_prefs_repo,
          pivotal_prefs_repo: pivotal_prefs_repo,
          backup_prefs_repo: backup_prefs_repo,
        ).execute
      end

      let(:matching_prefs)     { [] }
      let(:user_prefs_repo)    { UserPrefsRepoSpy.new(matching_prefs: matching_prefs) }
      let(:backup_prefs_repo)  { BackupPrefsRepoSpy.new }
      let(:pivotal_prefs_repo) { PivotalPrefsRepoStub.new(prefs: ["a pref"]) }

      class BackupPrefsRepoSpy
        def back_up_prefs(prefs)
          @backed_up = prefs
        end

        def has_backed_up_prefs?(prefs)
          prefs == @backed_up
        end
      end

      class UserPrefsRepoSpy
        def initialize(matching_prefs: nil)
          @matching_prefs = matching_prefs
        end

        def find_matching_prefs(*)
          @matching_prefs
        end

        def install_prefs(prefs)
          @installed = prefs
        end

        def has_installed_prefs?(prefs)
          prefs == @installed
        end
      end

      class PivotalPrefsRepoStub
        attr_reader :all

        def initialize(prefs: nil)
          @prefs = prefs
        end
      end
    end
  end
end
