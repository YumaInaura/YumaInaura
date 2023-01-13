require "application_system_test_case"

class FoosTest < ApplicationSystemTestCase
  setup do
    @foo = foos(:one)
  end

  test "visiting the index" do
    visit foos_url
    assert_selector "h1", text: "Foos"
  end

  test "should create foo" do
    visit foos_url
    click_on "New foo"

    click_on "Create Foo"

    assert_text "Foo was successfully created"
    click_on "Back"
  end

  test "should update Foo" do
    visit foo_url(@foo)
    click_on "Edit this foo", match: :first

    click_on "Update Foo"

    assert_text "Foo was successfully updated"
    click_on "Back"
  end

  test "should destroy Foo" do
    visit foo_url(@foo)
    click_on "Destroy this foo", match: :first

    assert_text "Foo was successfully destroyed"
  end
end
