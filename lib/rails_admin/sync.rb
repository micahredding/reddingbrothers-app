require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Sync < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :controller do
          proc do
            @object.sync
            redirect_to main_app.url_for(@object)
          end
        end

      end
    end
  end
end
