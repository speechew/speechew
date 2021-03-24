class ArticleDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :mailto, :article_path, :edit_article_path
  
  
  def view_columns
    @view_columns ||= {
      title: { source: "Article.title", cond: :like },
      status: { source: "Article.status", cond: :like }
    }
  end 

  private

  def data
    records.map do |record|
  
    ops = ''
    
      if options[:ca].can? :update, record then 
      ops = ops + " " + link_to('<i class="fas fa-pencil-alt"></i>'.html_safe, edit_article_path(record)) 
      end
  
      if options[:ca].can? :destroy, record then       
        ops = ops + " " + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, article_path(record), method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this article?' }) 
    end  
    
  
      { 
    title: record.title,
    status: record.status,
    ops: ops.html_safe
    }
    end
  end

  def get_raw_records
    # insert query here
  Article.where(deleted: false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
