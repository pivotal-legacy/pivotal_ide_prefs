require "ide_prefs_test_support/contracts/basic_prefs_repo_contract"

def assert_works_like_a_backup_prefs_repo(pref_factory: nil, backup_prefs_repo_factory: nil)
  describe "Backup Prefs Repo" do

    assert_works_like_basic_prefs_repo(
      pref_factory: pref_factory,
      prefs_repo_factory: backup_prefs_repo_factory,
    )

    describe "Backing Up Preferences" do
      describe "Scenario: Backing up a preference not already backed up" do
        context "Given a preference not already backed up" do
          let(:pref) { pref_factory.generate_pref }

          context "When I back it up into the backup prefs repo" do
            before do
              backup_prefs_repo.back_up_prefs([pref])
            end

            specify "Then it should copy the pref into the repo" do
              expect(backup_prefs_repo.all).to include pref
            end
          end
        end

        let(:backup_prefs_repo) { backup_prefs_repo_factory.call }
      end
    end
  end
end
