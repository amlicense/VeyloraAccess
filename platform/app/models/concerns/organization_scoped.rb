module OrganizationScoped
  extend ActiveSupport::Concern

  class_methods do
    def same_organization(*associations)
      validate do
        associations.each do |name|
          record = public_send(name)
          if record && record.organization != organization
            errors.add(name, "must belong to the same organization")
          end
        end
      end
    end
  end
end
