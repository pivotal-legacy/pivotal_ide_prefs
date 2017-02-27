require "cli/ide/preferences_directory"

module Cli::Ide
  describe PreferencesDirectory do
    context "several directories match" do
      it "chooses the one with the largest number on the end" do
        dir_with_biggest_number = "who/is/parker/dir10"
        dir_with_smallest_number = "real/directories/have/slashes/dir9"

        dir = PreferencesDirectory.new(
          directories: [dir_with_biggest_number, dir_with_smallest_number],
          match_pattern: /dir.*/
        ).to_s

        expect(dir).to eq(dir_with_biggest_number)
      end
    end

    context "no directories match" do
      it "returns the default" do
        default_dir = "some_dir"

        dir = PreferencesDirectory.new(
          directories: ["dir1", "dir2"],
          match_pattern: /^wont_match_anything$/,
          default: default_dir
        ).to_s

        expect(dir).to eq(default_dir)
      end
    end

    context "with new Jetbrains versioning scheme" do
      it "can pick a higher point in the same year even if it's in middle of dir list" do
        dirs = %w(rubymine/dir2016.1 rubymine/dir2016.2 rubymine/dir80)
        dir = PreferencesDirectory.new(
          directories: dirs,
          match_pattern: /dir.*/
        ).to_s

        expect(dir).to eq('rubymine/dir2016.2')
      end

      it "can pick a new year even if it's in middle of dir list" do
        dirs = %w(rubymine/dir2016.1 rubymine/dir2017.1 rubymine/dir80)
        dir = PreferencesDirectory.new(
          directories: dirs,
          match_pattern: /dir.*/
        ).to_s

        expect(dir).to eq('rubymine/dir2017.1')
      end
    end
  end
end
