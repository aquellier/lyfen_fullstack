# frozen_string_literal: true

require 'json'
require_relative 'database'

# votre code
json_file = File.expand_path('data.json', __dir__)
database = Database.new(json_file)
database.save_to_json
