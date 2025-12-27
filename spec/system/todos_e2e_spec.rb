require "rails_helper"

RSpec.describe "Todos E2E", type: :system do
  it "creates, updates, and deletes a todo" do
    visit todos_path
    click_link "New todo"

    fill_in "Name", with: "Write e2e spec"
    check "Done"
    click_button "Create Todo"

    expect(page).to have_content("Name:")
    expect(page).to have_content("Write e2e spec")
    expect(page).to have_content("Done:")
    expect(page).to have_content("true")

    click_link "Edit this todo"
    fill_in "Name", with: "Write better e2e spec"
    uncheck "Done"
    click_button "Update Todo"

    expect(page).to have_content("Write better e2e spec")
    expect(page).to have_content("false")

    click_button "Destroy this todo"

    expect(page).to have_current_path(todos_path)
    expect(page).not_to have_content("Write better e2e spec")
  end
end
