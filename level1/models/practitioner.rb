# frozen_string_literal: true

# Practitioner model, has_many communications
class Practitioner
  attr_reader :id, :first_name, :last_name, :express_delivery

  def initialize(id, first_name, last_name, express_delivery = false)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @express_delivery = express_delivery
  end
end
