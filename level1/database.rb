# frozen_string_literal: true

require 'date'
require_relative 'models/practitioner'
require_relative 'models/communication'
require_relative './revenue'

# Acting as a DB, interacting with json file
class Database
  def initialize(json_file)
    @json_file = json_file
    @practitioners = []
    @communications = []
    parse_and_load_data if File.exist?(@json_file)
  end

  def save_to_json
    revenues_hash = {}
    revenues_hash[:totals] = ::Revenue.new.calculate_revenue(@communications)
    File.open('output.json', 'w') do |f|
      f.write(JSON.pretty_generate(revenues_hash))
    end
  end

  private

  def parse_and_load_data
    parsed_json = JSON.parse(File.read(@json_file), symbolize_names: true)
    build_practitioners(parsed_json[:practitioners])
    build_communications(parsed_json[:communications])
  end

  def build_practitioners(practitioners)
    practitioners.each do |practitioner|
      @practitioners << Practitioner.new(
        practitioner[:id],
        practitioner[:first_name],
        practitioner[:last_name],
        practitioner[:express_delivery]
      )
    end
  end

  def build_communications(communications)
    communications.each do |communication|
      @communications << Communication.new(
        communication[:id],
        get_practitioner(@practitioners, communication),
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
