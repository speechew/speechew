# frozen_string_literal: true

class PageDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :page_path, :edit_page_path

  def view_columns
    @view_columns ||= {
      code: { source: 'Page.code', cond: :like },
      title: { source: 'Page.title', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_page_path(record), remote: true)}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, page_path(record), method: :delete,
                                                                                                      remote: true, data: { confirm: 'Are you sure you want to delete this page?' })
      end

      {
        code: record.code,
        title: record.title,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    Page.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
