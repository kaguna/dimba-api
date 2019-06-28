# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # This cops checks for parentheses around the arguments in method
      # definitions. Both instance and class/singleton methods are checked.
      class MethodDefParentheses < Cop
        include ConfigurableEnforcedStyle

        MSG_PRESENT = 'Use def without parentheses.'.freeze
        MSG_MISSING = 'Use def with parentheses when there are ' \
                      'parameters.'.freeze

        def on_def(node)
          args = node.arguments

          if require_parentheses?(args)
            if arguments_without_parentheses?(node)
              missing_parentheses(node)
            else
              correct_style_detected
            end
          elsif parentheses?(args)
            unwanted_parentheses(args)
          else
            correct_style_detected
          end
        end
        alias on_defs on_def

        private

        def autocorrect(node)
          lambda do |corrector|
            if node.args_type?
              # offense is registered on args node when parentheses are unwanted
              corrector.replace(node.loc.begin, ' ')
              corrector.remove(node.loc.end)
            else
              args_expr = node.arguments.source_range
              args_with_space = range_with_surrounding_space(args_expr, :left)
              just_space = range_between(args_with_space.begin_pos,
                                         args_expr.begin_pos)
              corrector.replace(just_space, '(')
              corrector.insert_after(args_expr, ')')
            end
          end
        end

        def require_parentheses?(args)
          style == :require_parentheses ||
            (style == :require_no_parentheses_except_multiline &&
             args.multiline?)
        end

        def arguments_without_parentheses?(node)
          node.arguments? && !parentheses?(node.arguments)
        end

        def missing_parentheses(node)
          add_offense(node, node.arguments.source_range, MSG_MISSING) do
            unexpected_style_detected(:require_no_parentheses)
          end
        end

        def unwanted_parentheses(args)
          add_offense(args, :expression, MSG_PRESENT) do
            unexpected_style_detected(:require_parentheses)
          end
        end
      end
    end
  end
end
