# frozen_string_literal: true

require 'avm/instances/runner'
require 'avm/path_string'
require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    module Instances
      module Runners
        class Deploy
          runner_with :help do
            desc 'Deploy for instance.'
            arg_opt '-r', '--reference', 'Git reference to deploy.'
            arg_opt '-a', '--append-dirs', 'Append directories to deploy (List separated by ":").'
            bool_opt '-T', '--no-request-test', 'Do not test web interface after deploy.'
            bool_opt '--no-remote', 'Shortcut to "--no-remote-read --no-remote-write"'
            bool_opt '--no-remote-read', 'Do not attempt to read on remote repository.'
            bool_opt '--no-remote-write', 'Do not attempt to write on remote repository.'
          end

          def run
            result = runner_context.call(:instance).deploy_instance(deploy_options).run
            if result.error?
              fatal_error result.to_s
            else
              infov 'Result', result.label
            end
          end

          def deploy_options
            { reference: parsed.reference,
              appended_directories: ::Avm::PathString.paths(parsed.append_dirs),
              no_request_test: parsed.no_request_test?, remote_read: remote_read?,
              remote_write: remote_write? }
          end

          # @return [Boolean]
          def remote_read?
            !(parsed.no_remote_read? || parsed.no_remote?)
          end

          # @return [Boolean]
          def remote_write?
            !(parsed.no_remote_write? || parsed.no_remote?)
          end
        end
      end
    end
  end
end
