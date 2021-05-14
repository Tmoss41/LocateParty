require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "creates group" do 
    Group.create(name: 'Tim')
       assert true
  end
    # test "the truth" do
  #   assert true
  # end
end
