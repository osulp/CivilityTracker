Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 44.56222682932014,
      'longitude'    => -123.26127102380366,
      'address'      => '2nd & Jefferson, Corvallis',
      'state'        => 'Oregon',
      'state_code'   => 'OR',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
