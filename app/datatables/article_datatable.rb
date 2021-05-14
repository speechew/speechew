# frozen_string_literal: true

class ArticleDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :h, :mailto, :article_path, :edit_article_path, :display_status

  def view_columns
    @view_columns ||= {
      title: { source: 'Article.title', cond: :like },
      status: { source: 'Article.status', cond: :like }
    }
  end

  private

  def data
    records.map do |record|
      ops = ''
      if options[:ca].can? :show, record
        ops = "#{ops} #{link_to('<i class="fas fa-eye"></i>'.html_safe, article_path(record))}"
      end
      if options[:ca].can? :update, record
        ops = "#{ops} #{link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_article_path(record))}"
      end

      if options[:ca].can? :destroy, record
        ops = ops + ' ' + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, article_path(record),
                                  method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this article?' })
      end

      {
        title: link_to(record.title, article_path(record)),
        status: record.display_status,
        ops: ops.html_safe
      }
    end
  end

  def get_raw_records
    where = {}
    where[:status] = params[:status] unless params[:status].nil?
    # insert query here
    if options[:ca].has_role? :admin
      Article.where(where)
    else
      Article.where(user_id: options[:ca].id).where(where)
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
