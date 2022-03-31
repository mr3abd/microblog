module Roleable
  module Generators
    module OrmHelpers
      def model_contents
        roles_array = roles.map(&:to_sym)
        <<-CONTENT
  # Edit this array to add roles to your model
  ROLES = #{roles_array}.freeze

  # Store the roles in the roles json column and cast to booleans
  store_accessor :roles, *ROLES

  # Cast roles to/from booleans
  ROLES.each do |role|
    scope role, -> { where("roles @> ?", { role => true }.to_json) }

    define_method(:"\#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"\#{role}?") { send(role) }
  end

  # You can use Postgres' jsonb operators to query the roles jsonb column
  # https://www.postgresql.org/docs/current/functions-json.html
  #
  # Query where roles contains:
  # scope :managers, -> { where("roles @> ?", {manager: true}.to_json) }

  def active_roles
    ROLES.select { |role| send(:"\#{role}?") }.compact
  end
        CONTENT
      end

      private

      def model_exists?
        File.exist?(File.join(destination_root, model_path))
      end

      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_roles_to_#{table_name}.rb$/).first
      end

      def migration_path
        db_migrate_path
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end
    end
  end
end
