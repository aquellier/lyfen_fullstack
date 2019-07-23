# frozen_string_literal: true

require 'date'
require_relative '../models/practitioner'
require_relative '../models/communication'

# Methods to build instances
class JsonBuilder
  def build_practitioners(target, practitioners)
    practitioners.each do |practitioner|
      target << Practitioner.new(
        practitioner[:id],
        practitioner[:first_name],
        practitioner[:last_name],
        practitioner[:express_delivery]
      )
    end
  end

  def build_communications(target, practitioners, communications)
    communications.each do |communication|
      target << Communication.new(
        communication[:id],
        get_practitioner(practitioners, communication),
        communication[:pages_number],
        communication[:color],
        Date.parse(communication[:sent_at])
      )
    end
  end

  def get_practitioner(practitioners, communication)
    practitioners.find do |practitioner|
      practitioner.id == communication[:practitioner_id]
    end
  end
end
