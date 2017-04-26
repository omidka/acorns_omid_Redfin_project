author='Omid Karimi'

require './features/step_definitions/redfin_home_page.rb'

redfinPage = RedfinPage.new
city = 'Irvine, CA'
numberOFBaths = '4+'
numberOfParking = '2+'
numberofBedsMinIndex = 4
numberofBedsMaxIndex = 2
yearBuiltMin = '1990'
yearBuiltMax = '2000'

Given(/^I navigate to Redfin$/) do
  visit '/'
end

When(/^User logs in to Redfin$/) do
  # find the sign in button and click it (two with same IDs)
  loginButton = all(redfinPage.HomePageSignIn)
  loginButton[0].click

  # fill up the email and passed and click submit button
  fill_in('emailInput', :with => 'okhub-redfin@yahoo.com')
  fill_in('passwordInput', :with => 'Assignement1')
  find(redfinPage.SignInFormSubmit).click
end

Then(/^Verify user is logged in$/) do
  userName = find('div[data-rf-test-id="userName"]').find('span[class^="nameText"]')
  userName.has_content?('Omid')
  puts "User name has been verified = #{userName.text}"
end

Then (/^Search for a property in a city$/) do
  searchBox = all('[type="search"]')
  puts "found #{searchBox.length} search box elements"
  puts "Search for City of #{city}"
  searchBox[0].set(city)
  searchButton = all('form[class="SearchBoxForm"] button[data-rf-test-name="searchButton"]')
  searchButton[0].click
  # waiting for the map to load
  sleep(6)
end

When (/^Narrow down the filters to find my property$/) do

  # select the min Bed
  find(redfinPage.FilterMinBeds).click
  sleep(2)
  availableMinBedOptions = all('div[class="option"]')
  puts "Choose the value of min bed #{availableMinBedOptions[numberofBedsMinIndex].text}"
  availableMinBedOptions[numberofBedsMinIndex].click

  # select the max Bed
  find(redfinPage.FilterMaxBeds).click
  sleep(2)
  availableMaxBedOptions = all('div[class="option"]')
  puts "Choose the value of max bed #{availableMaxBedOptions[numberofBedsMaxIndex].text}"
  availableMaxBedOptions[numberofBedsMaxIndex].click

  # click on more filters
  find(:css, 'button[data-rf-test-id="filterButton"]').click
  select(numberOFBaths, :from => 'baths')
  puts "Choose number of baths = #{numberOFBaths}"
  select(numberOfParking, :from => 'parking')
  puts "Choose number of Parking Spaces = #{numberOfParking}"
  select(yearBuiltMin, :from => 'yearBuiltMin')
  puts "Choose the Year Built Min = #{yearBuiltMin}"
  select(yearBuiltMax, :from => 'yearBuiltMax')
  puts "Choose the Year Built Max = #{yearBuiltMax}"

  # click the update search results button
  find('button[data-rf-test-name="submitButton"]').click

  # for now I am hardcoding the index of the search results here, however we can define a method to inject the index
  propertesFound = find('div[id="MapHomeCard_0"]').find('a[class="ViewDetailsButtonWrapper"] button')
  # going to the Property details (PDP)
  propertesFound.click
  # sleep time just for PDP page visibility
  sleep(5)
end

Then (/^Make sure the results are correct$/) do
  searchResultsCards = all('div[id^="MapHomeCard_"]')
  puts "#{searchResultsCards.length} Properties Have Been Found"
  i = 0
  loop do
    i += 1
    currentCard = all(redfinPage.PropertySearchedCards(i))
    if (i >= searchResultsCards.length)
      break
    end
    currentYearBuilt = find(redfinPage.PropertySearchedYearBuilt(i)).text

    puts "Results Number of Baths = #{currentCard[4].text} \nAnd number of Beds = #{currentCard[1].text}\nAnd the Year Built = #{currentYearBuilt}"
    if (currentCard[4].text.to_i < 4)
      scenario.fail!(raise(ArgumentError.new('Bathrooms did not match')))
    end
    if ((currentCard[1].text.to_i < 4) || (currentCard[1].text.to_i > 6))
      fail!(raise(ArgumentError.new('Bedrooms did not match')))
    end
    if ((currentYearBuilt.to_i < 1990) || (currentYearBuilt.to_i > 2000))
      fail!(raise(ArgumentError.new('Year Built did not match')))
    end
  end
end
