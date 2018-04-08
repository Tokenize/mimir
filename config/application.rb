require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mimir
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html = ''

      form_fields = [
        'textarea',
        'input',
        'select'
      ]

      elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

      elements.each do |e|
        if e.node_name.eql? 'label'
          html = %(#{e}).html_safe
        elsif form_fields.include? e.node_name
          e['class'] += ' is-invalid'
          if instance.error_message.kind_of?(Array)
            html = %(#{e}<div class="invalid-feedback">#{instance.error_message.uniq.join(', ')}</div>).html_safe
          else
            html = %(#{e}<div class="invalid-feedback">#{instance.error_message}</div>).html_safe
          end
        end
      end
      html
    }
  end
end
