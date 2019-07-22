# frozen_string_literal: true

# Communication model, belongs to practitioner
class Communication
  attr_reader :id, :practitioner, :pages_number, :color, :sent_at

  def initialize(id, practitioner, pages_number, color, sent_at)
    @id = id
    @practitioner = practitioner
    @pages_number = pages_number
    @color = color
    @sent_at = sent_at
  end
end
