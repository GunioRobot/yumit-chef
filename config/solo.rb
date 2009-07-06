#
# Example Chef Solo Config
cookbook_path [
  File.join(File.dirname(__FILE__), '..', 'site-cookbooks'),
  File.join(File.dirname(__FILE__), '..', 'cookbooks')
]
log_level :debug
Chef::Log::Formatter.show_time = false
