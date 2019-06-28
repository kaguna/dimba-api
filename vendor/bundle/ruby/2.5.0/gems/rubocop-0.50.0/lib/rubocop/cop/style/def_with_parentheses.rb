# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # This cop checks for parentheses in the definition of a method,
      # that does not take any arguments. Both instance and
      # class/singleton methods are checked.
      class DefWithParentheses < Cop
        MSG = "Omit the parentheses in defs when the method doesn't accept " \
              'any arguments.'.freeze

        def on_def(node)
          return if node.single_line?
          return unless !node.arguments? && node.arguments.loc.begin

          add_offense(node.arguments, :begin)
        end
        alias on_defs on_def

        private

        def autocorrect(node)
          lambda do |corrector|
            corrector.remove(node.loc.begin)
            corrector.remove(node.loc.end)
          end
        end
      end
    end
  end
end
