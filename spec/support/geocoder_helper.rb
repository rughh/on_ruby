module GeocoderHelper
  def stub_geocoder
    Geocoder.configure(lookup: :test)
    Geocoder::Lookup::Test.set_default_stub(
      [
        {
          'coordinates' => [45.1891676, 5.6997775],
          'address' => '8 Avenue Aristide Briand, 38600 Fontaine, France',
          'state' => 'Rhone-Alpes',
          'state_code' => 'RA',
          'country' => 'France',
          'country_code' => 'FR',
        }
      ]
    )
  end
end
