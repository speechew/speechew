# frozen_string_literal: true

class RoomDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :room_path, :edit_room_path

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Room.name']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Room.name']
  end

  private

  def data
    records.map do |record|
      ops = ''
      ops = link_to('<i class="fa fa-eye"> </i>'.html_safe, room_path(record))

      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fa fa-pencil"> </i>'.html_safe, edit_room_path(record), remote: true)}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, room_path(record), method: :delete,
                                                                                                      remote: true, data: { confirm: 'Are you sure you want to delete this room?' })
      end

      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name, ops
      ]
    end
  end

  def get_raw_records
    # insert query here
    Room.where(deleted: false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
