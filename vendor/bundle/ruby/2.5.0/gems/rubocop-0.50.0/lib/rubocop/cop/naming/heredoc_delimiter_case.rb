# frozen_string_literal: true

module RuboCop
  module Cop
    module Naming
      # This cop checks that your heredocs are using the configured case.
      # By default it is configured to enforce uppercase heredocs.
      #
      # @example
      #
      #   # EnforcedStyle: uppercase (default)
      #
      #   # good
      #   <<-SQL
      #     SELECT * FROM foo
      #   SQL
      #
      #   # bad
      #   <<-sql
      #     SELECT * FROM foo
      #   sql
      #
      # @example
      #
      #   # EnforcedStyle: lowercase
      #
      #   # good
      #   <<-sql
      #     SELECT * FROM foo
      #   sql
      #
      #   # bad
      #   <<-SQL
      #     SELECT * FROM foo
      #   SQL
      class HeredocDelimiterCase < Cop
        include Heredoc
        include ConfigurableEnforcedStyle

        MSG = 'Use %s heredoc delimiters.'.freeze

        def on_heredoc(node)
          return if correct_case_delimiters?(node)

          add_offense(node, :heredoc_end)
        end

        private

        def message(_node)
          format(MSG, style)
        end

        def correct_case_delimiters?(node)
          delimiter_string(node) == correct_delimiters(node)
        end

        def correct_delimiters(node)
          if style == :uppercase
            delimiter_string(node).upcase
          else
            delimiter_string(node).downcase
          end
        end
      end
    end
  end
end
