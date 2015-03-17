module ParamUtil
  extend ActiveSupport::Concern

  included do
    class ActionController::Parameters
      def delete_blank
        self.delete_if do |name, value| value.blank? end
      end
    end

    class ActiveRecord::Base
      def add_error_messages(error_messages)
        if error_messages
          error_messages.each do |name, messages|
            messages.each do |message|
              self.errors.add(name, message)
            end
          end
        end
      end
    end
  end
end
