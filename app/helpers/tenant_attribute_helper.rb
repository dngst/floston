module TenantAttributeHelper
  def tenant_attribute(user, attribute)
    user.tenant.class.human_attribute_name(attribute)
  end
end
