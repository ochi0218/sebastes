require 'spec_helper'

describe Order do
  it '入力値の検証' do
    Date.stub(:today).and_return(Date.new(2014,1,1))
    order = build(:order)
    order.delivery_date = Date.new(2014, 1, 10)

    expect(order).to be_valid
  end
end
