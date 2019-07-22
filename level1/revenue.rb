# frozen_string_literal: true

# Revenue calculation
class Revenue
  def calculate_revenue(communications)
    communications.group_by(&:sent_at).map do |date, communications|
      revenue = communications.map(&:communication_price).sum
      { sent_on: date.strftime('%F'), total: revenue.round(2) }
    end
  end
end
