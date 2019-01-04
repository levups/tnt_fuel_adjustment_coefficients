# !!! This gem is not maintened anymore !!!

Replaced by [fuel_surcharge](https://github.com/levups/fuel_surcharge), which handle more transporters.

# TNT Fuel Adjustment Coefficients fetcher

Retrieve current air and road rates applied to TNT shipping costs and
convert them to multipliers we can directly use in your app to calculate
precise shipping costs?

## Usage

Install the gem:

    $ gem install tnt_fuel_adjustment_coefficients

Run the gem:

    $ tnt_fuel_adjustment_coefficients

Get the result:

    # Fuel multipliers for novembre 2018
    # Fetched from https://www.tnt.com/express/fr_fr/site/home/comment-expedier/facturation/surcharges/baremes-et-historiques.html

    AIR_FUEL_MULTIPLIER  = 1.1850
    ROAD_FUEL_MULTIPLIER = 1.1210

Or use it in your app:

    require 'tnt_fuel_adjustment_coefficients'

    tnt = TNTFuelAdjustmentCoefficients.new
    tnt.road_multiplier      # 0.1121e1
    tnt.air_multiplier       # 0.1185e1
