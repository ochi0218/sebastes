require 'spec_helper'

describe Comment do
  it '入力値の検証' do
    comment = build(:comment)
    expect(comment).to be_valid
  end
end
