require "cli/configuration/repo_configuration"

module Cli::Configuration
  describe RepoConfiguration do
    context "no backup prefs repo location was provided" do
      it "calculates the backup location from the ide name" do
        configuration = RepoConfiguration.new(
          backups_location_base: "/backups_path",
          ide_name: "ide"
        )

        expect(configuration.backup_prefs_repo_location).to eq "/backups_path/ide"
      end
    end

    context "no pivotal prefs repo location specified" do
      it "calculates the pivotal prefs location from the ide name" do
        configuration = RepoConfiguration.new(
          pivotal_prefs_location_base: "/pivotal_prefs_path",
          ide_name: "ide"
        )

        expect(configuration.pivotal_prefs_repo_location).to eq "/pivotal_prefs_path/ide"
      end
    end
  end
end



