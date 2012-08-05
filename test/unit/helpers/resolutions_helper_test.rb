require 'test_helper'

class ResolutionsHelperTest < ActionView::TestCase

	test "test for compare_stacktace" do
 		assert compare_stacktace("aaaa", "bbbb")==98," Gena's error"
	end

end
