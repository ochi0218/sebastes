module ApplicationHelper
  def boolean_to_human(value)
    value ? t('boolean.human.yes_or_true') : t('boolean.human.no_or_false')
  end
end
