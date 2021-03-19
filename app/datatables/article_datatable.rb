class ArticleDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :mailto, :article_path, :edit_article_path
  
  
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Article.title', 'Article.content', 'Article.category']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Article.title', 'Article.content', 'Article.category']
  end

  private

  def data
    records.map do |record|
	
	  ops = ''
      ops = link_to('<i class="fa fa-eye"> </i>'.html_safe, article_path(record))
	  
      if options[:ca].can? :update, record then 
	    ops = ops + " " + link_to('<i class="fa fa-pencil"> </i>'.html_safe, edit_article_path(record), remote: true) 
      end
  
      if options[:ca].can? :destroy, record then       
        ops = ops + " " + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, article_path(record), method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this article?' }) 
	  end  
	  
	
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,		
		record.title, record.content, record.category, ops
      ]
    end
  end

  def get_raw_records
    # insert query here
	Article.where(deleted: false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
