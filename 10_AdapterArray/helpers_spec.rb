require 'minitest/autorun'
require_relative 'helpers'

describe "JoltageHelpers" do
  it "counts adapter paths" do 
    adapters = [ 0, 1, 4, 5, 6, 7, 10, 11, 12, 15, 16, 19, 22 ]
    helper = JoltageHelpers.new(adapters)
    assert_equal 8, helper.count_adapter_paths()
  end
end

