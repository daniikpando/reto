module PermissionOfUser
    extend ActiveSupport::Concern
    def is_user_normal?
      self.permittion_level >= 0
    end
    def is_user_editor?
      self.permittion_level >= 1
    end
    def is_user_admin?
      self.permittion_level >= 2
    end
end
