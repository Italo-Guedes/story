class ConvertPapertrailYamlColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :versions, :new_object, :jsonb # or :json
    add_column :versions, :new_object_changes, :jsonb # or :json

    reversible do |dir|
      dir.up do
        PaperTrail::Version.find_each do |version|
          version.update_column(:new_object, YAML.load(version.object)) if version.object
          version.update_column(:new_object_changes, YAML.load(version.object_changes)) if version.object_changes
        end
      end

      dir.down do
        PaperTrail::Version.find_each do |version|
          version.update_column(:object, version.new_object.to_yaml) if version.new_object
          version.update_column(:object_changes, version.new_object_changes.to_yaml) if version.new_object_changes
        end
      end
    end

    remove_column :versions, :object, :text
    remove_column :versions, :object_changes, :text
    rename_column :versions, :new_object, :object
    rename_column :versions, :new_object_changes, :object_changes
  end
end
