# frozen_string_literal: true

require_relative './services/revenue'
require_relative './services/json_builder'

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
    data = JSON.parse(File.read(@json_file), symbolize_names: true)
    JsonBuilder.new.build_practitioners(
      @practitioners,
      data[:practitioners]
    )
    JsonBuilder.new.build_communications(
      @communications,
      @practitioners,
      data[:communications]
    )
  end
end
