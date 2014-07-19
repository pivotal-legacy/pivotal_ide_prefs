module Spec
  module Support
    class FakeRepo
      def self.location
        File.expand_path(File.join(__dir__, "..", "fixtures", "fake_repo"))
      end
    end
  end
end
