def assert_works_like_basic_prefs_repo(pref_factory: nil, prefs_repo_factory: nil)
  describe "Copying Prefs into the Repo" do
    context "Given a pref" do
      let(:pref) { pref_factory.generate_pref }

      context "When I tell the prefs repo to copy the pref" do
        before do
          prefs_repo.copy(pref)
        end

        specify "Then it should create a pref in the repo with the same id and content" do
          copy = prefs_repo.all.find { |p| p.id == pref.id }
          expect(copy.contents).to eq(pref.contents)
        end
      end
    end

    let(:prefs_repo) { prefs_repo_factory.call }
  end
end
