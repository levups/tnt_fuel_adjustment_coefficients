# frozen_string_literal: true

require "bigdecimal"
require "http"

class TntFuelAdjustmentCoefficients
  def initialize
    @road_multiplier = extracted_values.first
    @air_multiplier  = extracted_values.last(3).first
  end

  def url
    "https://www.tnt.com/express/fr_fr/site/home/comment-expedier/facturation/surcharges/baremes-et-historiques.html"
  end

  def time_period
    return unless @road_multiplier

    @road_multiplier.first.to_s.strip
  end

  def road_multiplier
    return unless @air_multiplier

    format_multiplier @road_multiplier.last.to_s
  end

  def air_multiplier
    return unless @road_multiplier

    format_multiplier @air_multiplier.last.to_s
  end

  private

  def response
    ::HTTP.timeout(10).get(url)
  rescue HTTP::Error
    ''
  end

  # [
  #   [" novembre 2018 ",  "12,10%"],
  #   ["octobre 2018 ",    "11,95%"],
  #   [" septembre 2018 ", "11,95%"],
  #   [" novembre 2018 ",  "18,50%"],
  #   ["octobre 2018 ",    "17,50%"],
  #   [" septembre 2018 ", "17,50%"]
  # ]
  def extracted_values
    @extracted_values ||=
      response.to_s
              .scan(/Surcharge d[e']+(.*): (.*)<br>$/)
  end

  def format_multiplier(string)
    string.tr!("%", "")
    string.tr!(",", ".")

    number = (string.to_f / 100 + 1).round(4)
    BigDecimal(number.to_s)
  end
end
