require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to the /new page contains h1 New game" do
    visit new_url
    assert test: "New game"
    assert_selector "input", count: 1
    fill_in "word", with: "Bob"
    click_on ""
    all("p").each do |p|
      puts p.text
    end
  end
end
