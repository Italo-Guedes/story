# frozen_string_literal: true

# Papertrail helper method to auditing purposes
module PaperTrail
  # Papertrail helper method to auditing purposes
  class Version < ActiveRecord::Base
    include PaperTrail::VersionConcern

    def translated_changeset
      result_hash = {}
      set = changeset || {}

      clean_hash(set)
      set.each do |k, v|
        name = k
        values =
          if name.end_with? '_id'
            search_relations(name, v)
          else
            v
          end
        t_name = I18n.t("activerecord.attributes.#{item_type.underscore}.#{name}")
        name = t_name unless t_name.start_with?('<span') || t_name.start_with?('translation missing')
        result_hash[name] = values
      end
      result_hash
    end

    def clean_hash(hash)
      return unless hash

      IGNORED_KEYS.each { |k| hash.delete k }
    end

    IGNORED_KEYS = %w[
      encrypted_password
      reset_password_token
      confirmation_token
      remember_created_at
    ].freeze

    private

    def search_relations(name, values)
      name = name.sub(/_id$/, '')
      entity1 = relation_search(name, values[0])
      entity2 = relation_search(name, values[1])
      [entity1, entity2]
    end

    def relation_search(name, id)
      name.classify.constantize.find(id)
    rescue StandardError
      "id: #{id}"
    end
  end
end
