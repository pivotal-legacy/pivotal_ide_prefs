require "persistence/private/file_database"

module Cli
  module Logging
    class LogSymlink
      def klass
        Persistence::Private::FileDatabase
      end

      def method_to_log
        :symlink
      end

      def before(logger: nil, args: [])
        relative_path, _ = args

        logger.debug "Symlinking preference #{relative_path}"
      end
    end
  end
end
