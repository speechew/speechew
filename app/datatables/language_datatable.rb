# frozen_string_literal: true

class LanguageDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :language_path, :edit_language_path

  def view_columns
    @view_columns ||= {
      name: { source: 'Language.name', cond: :like },
      language_code: { source: 'Language.language_code', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = ops + ' ' + link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_language_path(record),
                                  remote: true)
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, language_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this language?' })
      end

      {
        name: record.name,
        language_code: record.language_code,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    Language.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
