require "persistence/private/file_database"

module Cli
  module Logging
    class LogFileCopy
      def klass
        Persistence::Private::FileDatabase
      end

      def method_to_log
        :copy_file
      end

      def before(logger: nil, args: [])
        relative_path, _ = args

        logger.debug "Copying preference #{relative_path}"
      end
    end
  end
end
