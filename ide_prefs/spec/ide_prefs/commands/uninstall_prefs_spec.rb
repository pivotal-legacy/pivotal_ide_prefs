require "ide_prefs/commands/uninstall_prefs"

module IdePrefs::Commands
  describe UninstallPrefs do
    it "destroys any installed prefs" do
      execute_uninstall

      expect(user_prefs_repo).to have_destroyed_prefs(pivotal_prefs_repo.all)
    end

    it "restores any backed up prefs"
  end
end
