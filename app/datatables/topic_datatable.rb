# frozen_string_literal: true

class TopicDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :topic_path, :edit_topic_path

  def view_columns
    @view_columns ||= {
      name: { source: 'Topic.name', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_topic_path(record), remote: true)}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, topic_path(record), method: :delete,
                                                                                                       remote: true, data: { confirm: 'Are you sure you want to delete this topic?' })
      end

      {
        name: record.name,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    Topic.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
