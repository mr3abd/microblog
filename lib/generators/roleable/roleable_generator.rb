require "rails/generators/active_record"
require "generators/roleable/orm_helpers"

class RoleableGenerator < ActiveRecord::Generators::Base
  argument :roles, type: :array, default: [], banner: "role role"

  include Roleable::Generators::OrmHelpers
  source_root File.expand_path("templates", __dir__)

  def copy_roles_migration
    return unless (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))

    migration_template "migration_existing.erb", "#{migration_path}/add_roles_to_#{table_name}.rb", migration_version: migration_version
  end

  def inject_roleable_content
    return unless model_exists?

    class_path = namespaced? ? class_name.to_s.split("::") : [class_name]

    # content = model_contents.split("\n").map { |line| ("  " * class_path.size(-1)) + line }.join("\n") << "\n"

    inject_into_class(model_path, class_path.last, model_contents << "\n")
  end

  def migration_version
    "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
  end
end
