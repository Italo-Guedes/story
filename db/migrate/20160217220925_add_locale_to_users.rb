class AddLocaleToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :locale, :string, default: Rails.application.config.i18n.default_locale
  end
end
