# frozen_string_literal: true

class CategoryDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :category_path, :edit_category_path

  def view_columns
    @view_columns ||= { name: { source: 'Category.name', cond: :like } }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :update, record
        ops = ops + ' ' + link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_category_path(record),
                                  remote: true)
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, category_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this category?' })
      end

      {
        name: record.name,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    # insert query here
    Category.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
