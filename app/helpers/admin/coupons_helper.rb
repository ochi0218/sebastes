module Admin::CouponsHelper
  #
  # クーポンコードを表示用の文字列に変換する
  #
  def coupon_code_to_human(value)
    return value if value.length != 12
    "#{value[0..3]}-#{value[4..7]}-#{value[8..11]}"
  end
end
