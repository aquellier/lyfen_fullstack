# frozen_string_literal: true

# rspec app_spec.rb

require 'rspec'
require_relative '../app.rb'

RSpec.describe 'Prices calculator', type: :model do
  let(:data)   { JSON.parse(File.read('data.json'), symbolize_names: true) }
  let(:output) { JSON.parse(File.read('output.json'), symbolize_names: true) }
  let(:practitioners) do
    practitioners = []
    JsonBuilder.new.build_practitioners(
      practitioners,
      data[:practitioners]
    )
    practitioners
  end
  let(:communications) do
    communications = []
    JsonBuilder.new.build_communications(
      communications,
      practitioners,
      data[:communications]
    )
    communications
  end

  it 'returns the correct price for a communication' do
    expect(communications[1].communication_price).to eq(0.77)
    expect(communications[2].communication_price).to eq(1.19)
  end

  it 'returns the correct revenues for a set of communications' do
    expect(Revenue.new.calculate_revenue(communications))
      .to eq(output[:totals])
  end
end
