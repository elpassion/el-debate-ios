module Fastlane
  module Actions
    class PullRequestNumberAction < Action
      def self.run(params)
        branch = GitBranchAction.run(params)

        unless branch == "master"
          UI.important "Last message is not a pull request merge commit - not a master branch."
          return nil
        end

        last_git_commit = LastGitCommitAction.run(params)[:message]

        if match = last_git_commit.match(/Merge pull request #(\d+) from .+/)
          version = match.captures.first
          UI.success "Found pull request number ##{version}."
          version
        else
          UI.important "Last message is not a pull request merge commit - commit message mismatch."
          nil
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Returns a number of pull request"
      end

      def self.details
        "Returns a number of pull request"
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.return_value
        "Pull request number or nil"
      end

      def self.authors
        ["turekj"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
