module Acceptance
  module Features
    class UserPreferences
      def destroy
        system "rm -rf tmp/"
      end

      def present?
        Dir.glob("tmp/RubyminePrefs/**/*").any? { |path| File.file?(path) }
      end
    end
  end
end
