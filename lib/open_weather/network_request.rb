require "httparty"
require "open_weather"
require "json"
require_relative "helpers/helpers"
require "logger"

module OpenWeather
  class NetworkRequest
    @helper = Helpers.new
    @url = "pro.openweathermap.org/data/2.5/forecast/hourly?"
    def self.by_city(main_url: "", name: "", units: "standard", lang: "en")
      api_key = OpenWeather.configuration.api_key
      uri = @helper.name_to_url(@url, name, api_key, units, lang)
      begin
        @response = HTTParty.get(uri)
      rescue StandardError => e
        logger = Logger.new($stdout)
        logger.error("Network is required")
        return []
      end
      if @response.message == "Unauthorized" || @response.code == 404
        logger = Logger.new($stdout)
        logger.error("Api Key is required")
        return []
      end
      @helper.to_json(@response.body)
    end

    def self.by_city_id(main_url: "", id: "", units: "standard", lang: "en")
      api_key = OpenWeather.configuration.api_key
      uri = @helper.id_to_url(@url, id, api_key, units, lang)
      begin
        @response = HTTParty.get(uri)
      rescue StandardError => e
        logger = Logger.new($stdout)
        logger.error("Network is required")
        return []
      end
      if @response.message == "Unauthorized" || @response.code == 404
        logger = Logger.new($stdout)
        logger.error("Api Key is required")
        return []
      end
      @helper.to_json(@response.body)
    end

    def self.by_coords(main_url: "", coords: [], units: "standard", lang: "en")
      api_key = OpenWeather.configuration.api_key
      uri = @helper.cords_to_url(@url, coords, api_key, units, lang)

      begin
        @response = HTTParty.get(uri)
      rescue StandardError => e
        logger = Logger.new($stdout)
        logger.error("Network is required")
        return []
      end
      if @response.message == "Unauthorized" || @response.code == 404
        logger = Logger.new($stdout)
        logger.error("Api Key is required")
        return []
      end
      @helper.to_json(@response.body)
    end

    def self.by_zip(main_url: "", zipcode: "", country: "", units: "standard", lang: "en")
      api_key = OpenWeather.configuration.api_key
      uri = @helper.zipcode_to_url(@url, zipcode, country, api_key, units, lang)
      begin
        @response = HTTParty.get(uri)
      rescue StandardError => e
        logger = Logger.new($stdout)
        logger.error("Network is required")
        return []
      end
      if @response.message == "Unauthorized" || @response.code == 404
        logger = Logger.new($stdout)
        logger.error("Api Key is required")
        return []
      end
      @helper.to_json(@response.body)
    end
  end
end
