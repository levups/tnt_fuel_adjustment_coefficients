# frozen_string_literal: true

require "minitest/autorun"
require "minitest/stub_any_instance"
require "tnt_fuel_adjustment_coefficients"

class TnTFuelAdjustmentCoefficientsTest < Minitest::Test
  def test_time_period
    nominal_case do
      assert_equal "novembre 2018", @adjustement_coefficient.time_period
    end

    failing_case do
      assert_nil @adjustement_coefficient.time_period
    end
  end

  def test_air_multiplier
    nominal_case do
      assert_equal 1.185, @adjustement_coefficient.air_multiplier
    end

    failing_case do
      assert_nil @adjustement_coefficient.air_multiplier
    end
  end

  def test_road_multiplier
    nominal_case do
      assert_equal 1.121, @adjustement_coefficient.road_multiplier
    end

    failing_case do
      assert_nil @adjustement_coefficient.road_multiplier
    end
  end

  private

  # HTTP would return arrays of unfreeze string so here we have to emulate it
  def extracted_values
    [
      [+" novembre 2018 ",  +"12,10%"],
      [+"octobre 2018 ",    +"11,95%"],
      [+" septembre 2018 ", +"11,95%"],
      [+" novembre 2018 ",  +"18,50%"],
      [+"octobre 2018 ",    +"17,50%"],
      [+" septembre 2018 ", +"17,50%"]
    ]
  end

  def nominal_case
    TntFuelAdjustmentCoefficients.stub_any_instance(:extracted_values,
                                                    extracted_values) do
      @adjustement_coefficient = TntFuelAdjustmentCoefficients.new
      yield
    end
  end

  def failing_case
    TntFuelAdjustmentCoefficients.stub_any_instance :extracted_values, [] do
      @adjustement_coefficient = TntFuelAdjustmentCoefficients.new
      yield
    end
  end
end
