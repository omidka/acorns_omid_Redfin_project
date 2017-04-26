# This script will evaluate the search results from Edmund website.
Author = 'Omid Karimi'

require "../lib/get_edmunds_API_response"

# Edmunds retrieve API response
describe GetEdmundsAPIResponse do
  edmundsAPIKey = 'r857skh7dzvpw5u3spgbh6sf'
  carMake = 'Nissan'
  carModel = 'Rogue'
  carYear = '2010'
  url = "https://api.edmunds.com/api/vehicle/v2/#{carMake}/#{carModel}/#{carYear}?view=full&fmt=json&api_key=#{edmundsAPIKey}"


  describe ".getResponse" do
    context "get_make_and_model_and_year" do
      context "given '#{carMake}, #{carModel}, #{carYear}'" do
        it "returns API response status and body" do
          apiResponse = GetEdmundsAPIResponse.getResponse(carMake, carModel, carYear, edmundsAPIKey)
          expect(apiResponse[0]).to eql(200)
          expect(apiResponse[1]['make']['name']).to eql(carMake)
          expect(apiResponse[1]['model']['name']).to eql(carModel)
          expect(apiResponse[1]['year']).to eql(carYear.to_i)
          puts "Verified the query response - Car Make = #{apiResponse[1]['make']['name']}"
          puts "Verified the query response - Car Model = #{apiResponse[1]['model']['name']}"
          puts "Verified the query response - Car Year = #{apiResponse[1]['year']}"
        end
      end
    end
  end
end
