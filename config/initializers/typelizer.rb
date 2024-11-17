Typelizer.configure do |config|
  config.output_dir = Rails.root.join("app/frontend/types/typelizer")
  config.types_import_path = "$types/typelizer"
  config.verbatim_module_syntax = true
end
