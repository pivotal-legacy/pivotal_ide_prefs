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
  end
end
