# frozen_string_literal: true

module Avm
  module EacWebappBase0
    module Instances
      class Deploy
        module Version
          VERSION_TARGET_PATH = 'VERSION'

          def version
            ([::Time.now, commit_reference] + version_git_refs).join('|')
          end

          def version_git_refs
            git_remote_hashs.select { |_name, sha1| sha1 == commit_reference }.keys
              .map { |ref| ref.gsub(%r{\Arefs/}, '') }.reject { |ref| ref == 'HEAD' }
          end

          def version_target_path
            VERSION_TARGET_PATH
          end
        end
      end
    end
  end
end
