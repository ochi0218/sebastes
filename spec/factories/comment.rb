FactoryGirl.define do
  factory :comment do
    contents '日記に対するコメント'
    diary_id 1
    user_id 1
  end
end
