require "application_system_test_case"

class KnowledgeBooksTest < ApplicationSystemTestCase
  setup do
    @knowledge_book = knowledge_books(:one)
  end

  test "visiting the index" do
    visit knowledge_books_url
    assert_selector "h1", text: "Knowledge Books"
  end

  test "creating a Knowledge book" do
    visit knowledge_books_url
    click_on "New Knowledge Book"

    fill_in "Code", with: @knowledge_book.code
    fill_in "Content", with: @knowledge_book.content
    check "Deleted" if @knowledge_book.deleted
    fill_in "Title", with: @knowledge_book.title
    click_on "Create Knowledge book"

    assert_text "Knowledge book was successfully created"
    click_on "Back"
  end

  test "updating a Knowledge book" do
    visit knowledge_books_url
    click_on "Edit", match: :first

    fill_in "Code", with: @knowledge_book.code
    fill_in "Content", with: @knowledge_book.content
    check "Deleted" if @knowledge_book.deleted
    fill_in "Title", with: @knowledge_book.title
    click_on "Update Knowledge book"

    assert_text "Knowledge book was successfully updated"
    click_on "Back"
  end

  test "destroying a Knowledge book" do
    visit knowledge_books_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Knowledge book was successfully destroyed"
  end
end
