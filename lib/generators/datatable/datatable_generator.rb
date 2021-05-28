# frozen_string_literal: true

class DatatableGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :coffeescript, type: :boolean, default: true, desc: 'Include Coffeescript file'

  def generate_coffeescript
    if options.coffeescript?
      template 'javascript.js.coffee', "app/assets/javascripts/#{file_name.underscore}.js.coffee"
    end
  end

  def create_datatable_file
    template 'datatable.rb', "app/datatables/#{file_name}_datatable.rb"
  end
end
