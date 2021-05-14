# frozen_string_literal: true

class FeedbackDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :feedback_path, :edit_feedback_path, :display_status

  def view_columns
    @view_columns ||= {
      fluency: { source: 'Feedback.fluency', cond: :like },
      vocabulary: { source: 'Feedback.vocabulary', cond: :like },
      grammar: { source: 'Feedback.grammar', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''
      if options[:ca].can? :show, record
        ops = "#{ops} #{link_to('<i class="fas fa-eye"></i>'.html_safe, feedback_path(record))}"
      end
      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_feedback_path(record))}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, feedback_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this feedback?' })
      end

      {
        fluency: record.fluency,
        vocabulary: record.vocabulary,
        grammar: record.grammar,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    Feedback.where(given_to_id: options[:ca].id).where(deleted: false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
