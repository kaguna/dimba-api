class BaseQuery
  attr_reader :relation

  class << self
    delegate :call, to: :new
  end

  def initialize(relation = nil)
    @relation = relation
  end

  def call
    raise NotImplementedError, 'call method must implement query logic'
  end
end
