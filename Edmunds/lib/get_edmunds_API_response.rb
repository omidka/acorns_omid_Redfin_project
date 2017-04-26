require 'faraday'
require 'json'

class GetEdmundsAPIResponse
  def self.getResponse(make, model, year, apiKey)
    if make.empty? || model.empty? || year.empty?
      0
    else
      myUrl = "https://api.edmunds.com/api/vehicle/v2/#{make}/#{model}/#{year}?view=full&fmt=json&api_key=#{apiKey}"
      request = Faraday.new(:url => myUrl)
      response = request.get
      parsedResponse = JSON.parse(response.body)
      return response.status, parsedResponse
    end
  end
end