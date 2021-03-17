class CountryDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :h, :mailto, :country_path, :edit_country_path
  
  
  def view_columns
    @view_columns ||= {
      name: { source: "Country.name", cond: :like },
      country_code: { source: "Country.country_code", cond: :like },
      continent_name: { source: "Country.continent_name", cond: :like }
    }
  end 

  private

  def data
    records.map do |record|
  
    ops = ''
    
      if options[:ca].can? :update, record then 
      ops = ops + " " + link_to('<i class="fas fa-pencil-alt"> </i>'.html_safe, edit_country_path(record), remote: true) 
      end
  
      if options[:ca].can? :destroy, record then       
        ops = ops + " " + link_to('<i class="fa fa-times-circle"> </i>'.html_safe, country_path(record), method: :delete, remote: true, data: { confirm: 'Are you sure you want to delete this country?' }) 
    end  
    
  
    { 
    name: record.name,
    country_code: record.country_code,
    continent_name: record.continent_name, 
    ops: ops.html_safe
    }
    end
  end

  def get_raw_records
    # insert query here
  Country.where(deleted: false)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
