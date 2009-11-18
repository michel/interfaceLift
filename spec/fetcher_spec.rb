require File.dirname(__FILE__) + '/spec_helper'

include InterfaceLift
describe Fetcher do
  it "should work" do
    object = mock()
    object.expects(:expected_method).at_least(9001)
    3.times { object.expected_method }
    object = mock()
    object.expects(:expected_method).at_least(2)
    object.expected_method
  end
end