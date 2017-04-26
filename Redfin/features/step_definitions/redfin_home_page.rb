author='Omid Karimi'

# to make it more page oriented, I created this page Ruby file, which later on can also pass dynamic locators
class RedfinPage
  def HomePageSignIn
    return redfinLoginButton = 'div[class="text"] [class^="link"] span[class="hoverWrapper"]'
  end

  def SignInFormSubmit
    return submitButton = 'button[data-rf-test-name="submitButton"]'
  end

  def PropertySearchedCards(index)
    return 'div[id="MapHomeCard_' + index.to_s + '"] div[class="HomeStats"] div'
  end

  def PropertySearchedYearBuilt(index)
    return 'div[id="MapHomeCard_' + index.to_s + '"] [data-rf-test-name="homecard-amenities-year-built"]'
  end

  def FilterMinBeds
    return 'span[class$="minBeds"] span[class="container"]'
  end

  def FilterMaxBeds
    return 'span[class$="maxBeds"] span[class="container"]'
  end
end