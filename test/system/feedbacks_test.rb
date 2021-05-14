# frozen_string_literal: true

require 'application_system_test_case'

class FeedbacksTest < ApplicationSystemTestCase
  setup do
    @feedback = feedbacks(:one)
  end

  test 'visiting the index' do
    visit feedbacks_url
    assert_selector 'h1', text: 'Feedbacks'
  end

  test 'creating a Feedback' do
    visit feedbacks_url
    click_on 'New Feedback'

    check 'Deleted' if @feedback.deleted
    fill_in 'Fluency', with: @feedback.fluency
    fill_in 'Given by', with: @feedback.given_by_id
    fill_in 'Given to', with: @feedback.given_to_id
    fill_in 'Grammar', with: @feedback.grammar
    fill_in 'Notes', with: @feedback.notes
    fill_in 'Vocabulary', with: @feedback.vocabulary
    click_on 'Create Feedback'

    assert_text 'Feedback was successfully created'
    click_on 'Back'
  end

  test 'updating a Feedback' do
    visit feedbacks_url
    click_on 'Edit', match: :first

    check 'Deleted' if @feedback.deleted
    fill_in 'Fluency', with: @feedback.fluency
    fill_in 'Given by', with: @feedback.given_by_id
    fill_in 'Given to', with: @feedback.given_to_id
    fill_in 'Grammar', with: @feedback.grammar
    fill_in 'Notes', with: @feedback.notes
    fill_in 'Vocabulary', with: @feedback.vocabulary
    click_on 'Update Feedback'

    assert_text 'Feedback was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Feedback' do
    visit feedbacks_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Feedback was successfully destroyed'
  end
end
