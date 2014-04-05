module ApplicationHelper
  #
  # 真偽値を表示用の文字列に変換する。
  #
  def boolean_to_human(value)
    value ? t('boolean.human.yes_or_true') : t('boolean.human.no_or_false')
  end
end
