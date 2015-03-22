require "ide_prefs_test_support/contracts/basic_prefs_repo_contract"

def assert_works_like_user_prefs_repo(pref_factory: nil, user_prefs_repo_factory: nil)
  describe "User Prefs Repo" do

    assert_works_like_basic_prefs_repo(pref_factory: pref_factory, prefs_repo_factory: user_prefs_repo_factory)

    describe "Querying the repo for matching prefs that are not 'installed'" do
      context "Given one preference that's in the repo as a regular user preference" do
        before do
          @regular_pref = pref_factory.generate_pref
          user_prefs_repo.copy(@regular_pref)
        end

        context "And another preference in the repo that's been 'installed'" do
          before do
            @installed_pref = pref_factory.generate_pref
            user_prefs_repo.install_prefs([@installed_pref])
          end

          context "When I query the repo for matching uninstalled prefs with both the regular pref and the installed pref" do
            let(:matching_prefs) do
              user_prefs_repo.find_matching_uninstalled_prefs([@regular_pref, @installed_pref])
            end

            specify "Then it should return the regular pref" do
              expect(matching_prefs).to include @regular_pref
            end

            specify "But it should not return the installed pref" do
              expect(matching_prefs).not_to include @installed_pref
            end
          end
        end
      end
    end

    describe "Installing Preferences into the Repo" do
      context "Given a pref not already in the repo" do
        let(:pref) { pref_factory.generate_pref }

        context "When I tell the user prefs repo to install it" do
          before do
            user_prefs_repo.install_prefs([pref])
          end

          specify "Then it should add it to the repo" do
            expect(user_prefs_repo.all).to include pref
          end

          specify "And it should return it when queried for all installed_prefs" do
            expect(user_prefs_repo.installed_prefs).to include pref
          end
        end
      end

      context "Given a pref ALREADY in the repo" do
        let(:pref) { pref_factory.generate_pref }

        before do
          user_prefs_repo.install_prefs([pref])
        end

        context "When I try to install it for the second time" do
          before do
            user_prefs_repo.install_prefs([pref])
          end

          specify "Then it should ignore it since it's a duplicate" do
            num_times_installed = user_prefs_repo.all.select { |p| p == pref }.count
            expect(num_times_installed).to eq 1
          end
        end
      end
    end

    let(:user_prefs_repo) { user_prefs_repo_factory.call }
  end
end
