# frozen_string_literal: true

module Cask
  class Cmd
    # Implementation of the `brew cask doctor` command.
    #
    # @api private
    class Doctor < AbstractCommand
      def self.max_named
        0
      end

      def self.description
        "Checks for configuration issues."
      end

      def run
        require "diagnostic"

        success = true

        checks = Homebrew::Diagnostic::Checks.new(verbose: true)
        checks.cask_checks.each do |check|
          out = checks.send(check)

          if out.present?
            success = false
            puts out
          end
        end

        raise CaskError, "There are some problems with your setup." unless success
      end
    end
  end
end
