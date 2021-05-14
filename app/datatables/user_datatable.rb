# frozen_string_literal: true

class UserDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :user_view_path

  def view_columns
    @view_columns ||= {
      name: { source: 'User.full_name', cond: :like },
      email: { source: 'User.email', cond: :like },
      sign_in_count: { source: 'User.sign_in_count', cond: :like },
      current_sign_in_at: { source: 'User.current_sign_in_at', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''

      if options[:ca].can? :show, record
        ops = "#{ops} #{link_to('<i class="fas fa-eye"></i>'.html_safe, user_view_path(id: record.id))}"
      end

      {
        name: "#{record.full_name.nil? ? '' : record.full_name}</br>#{record.display_roles}".html_safe,
        email: record.email,
        sign_in_count: record.sign_in_count,
        current_sign_in_at: record.current_sign_in_at.nil? ? 'N/A' : record.current_sign_in_at,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    where = {}

    # insert query here
    User.where(where)
  end
end
