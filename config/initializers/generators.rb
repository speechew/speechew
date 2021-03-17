Rails.application.config.generators do |g|
  g.template_engine :custom
  g.javascript_engine :custom 
  g.fallbacks[:custom] = :erb # or haml/slim etc
end