defmodule Geolix.Result.CountryTest do
  use ExUnit.Case, async: false

  alias Geolix.Result.Country

  test "result type" do
    assert %Country{} = Geolix.lookup("2.125.160.216", :fixture_country)
  end

  test "regular country" do
    ip     = { 216, 160, 83, 56 }
    result = Geolix.lookup(ip, :fixture_country)

    assert result.traits.ip_address == ip

    assert "NA" == result.continent.code
    assert 6255149 == result.continent.geoname_id
    assert "Северная Америка" == result.continent.names[:ru]

    assert 6252001 == result.country.geoname_id
    assert "US" == result.country.iso_code
    assert "アメリカ合衆国" == result.country.names[:ja]

    assert 2635167 == result.registered_country.geoname_id
    assert "GB" == result.registered_country.iso_code
    assert "Vereinigtes Königreich" == result.registered_country.names[:de]
  end

  test "represented country" do
    ip     = { 202, 196, 224, 0 }
    result = Geolix.lookup(ip, :fixture_country)

    assert result.traits.ip_address == ip

    assert "AS" == result.continent.code
    assert 6255147 == result.continent.geoname_id
    assert "Asie" == result.continent.names[:fr]

    assert 1694008 == result.country.geoname_id
    assert "PH" == result.country.iso_code
    assert "Filipinas" == result.country.names[:"pt-BR"]

    assert result.registered_country == result.country

    assert 6252001 == result.represented_country.geoname_id
    assert "US" == result.represented_country.iso_code
    assert "Estados Unidos" == result.represented_country.names[:es]
    assert "military" == result.represented_country.type
  end
end
