# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  test 'should not save country without name' do
    country = Country.new
    assert_not country.save
  end
end
