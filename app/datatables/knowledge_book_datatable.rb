# frozen_string_literal: true

class KnowledgeBookDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :knowledge_book_path, :edit_knowledge_book_path

  def view_columns
    @view_columns ||= {
      code: { source: 'KnowledgeBook.code', cond: :like },
      title: { source: 'KnowledgeBook.title', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fas fa-pencil-alt"></i>'.html_safe,
                                edit_knowledge_book_path(record))}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, knowledge_book_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this knowledge book?' })
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
    KnowledgeBook.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
