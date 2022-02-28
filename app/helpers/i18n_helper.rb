# app/helpers/i18n_helper.rb

module I18nHelper
  def translate(key, **options)
    super(key, **(options.merge(raise: true)))
  rescue I18n::MissingTranslationData
    "missing translation: #{key}"
  end
  alias :t :translate
end
