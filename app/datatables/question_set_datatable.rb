# frozen_string_literal: true

class QuestionSetDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :question_set_path, :edit_question_set_path

  def view_columns
    @view_columns ||= {
      title: { source: 'QuestionSet.title', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = ops + ' ' + link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_question_set_path(record),
                                  remote: true)
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, question_set_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this question_set?' })
      end

      {
        title: record.title,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    QuestionSet.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
