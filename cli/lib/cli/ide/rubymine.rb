module Cli
  module Ide
    class Rubymine
      def locations
        {
          user_prefs_repo:    File.expand_path(File.join("~", "Library", "Preferences", "RubyMine60")),
          pivotal_prefs_repo: File.expand_path(File.join(__dir__, "..", "..", "..", "..", "pref_sources", "RubyMine")),
        }
      end
    end
  end
end
