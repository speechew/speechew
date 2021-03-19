require 'test_helper'

class KnowledgeBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @knowledge_book = knowledge_books(:one)
  end

  test "should get index" do
    get knowledge_books_url
    assert_response :success
  end

  test "should get new" do
    get new_knowledge_book_url
    assert_response :success
  end

  test "should create knowledge_book" do
    assert_difference('KnowledgeBook.count') do
      post knowledge_books_url, params: { knowledge_book: { code: @knowledge_book.code, content: @knowledge_book.content, deleted: @knowledge_book.deleted, title: @knowledge_book.title } }
    end

    assert_redirected_to knowledge_book_url(KnowledgeBook.last)
  end

  test "should show knowledge_book" do
    get knowledge_book_url(@knowledge_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_knowledge_book_url(@knowledge_book)
    assert_response :success
  end

  test "should update knowledge_book" do
    patch knowledge_book_url(@knowledge_book), params: { knowledge_book: { code: @knowledge_book.code, content: @knowledge_book.content, deleted: @knowledge_book.deleted, title: @knowledge_book.title } }
    assert_redirected_to knowledge_book_url(@knowledge_book)
  end

  test "should destroy knowledge_book" do
    assert_difference('KnowledgeBook.count', -1) do
      delete knowledge_book_url(@knowledge_book)
    end

    assert_redirected_to knowledge_books_url
  end
end
