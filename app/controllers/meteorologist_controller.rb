require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    geo_url ="http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.gsub(" ","+")

    parsed_geo_data = JSON.parse(open(geo_url).read)

    @geo_latitude = parsed_geo_data["results"][0]["geometry"]["location"]["lat"].to_s

    @geo_longitude = parsed_geo_data["results"][0]["geometry"]["location"]["lng"].to_s

    weather_url = "https://api.darksky.net/forecast/a907916f2a5d831967aadea6833592a7/"+@geo_latitude+","+@geo_longitude

    parsed_weather_data = JSON.parse(open(weather_url).read)

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
