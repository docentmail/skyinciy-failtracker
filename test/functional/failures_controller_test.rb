require 'test_helper'

class FailuresControllerTest < ActionController::TestCase
  setup do
    @failure = failures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:failures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create failure" do
    assert_difference('Failure.count') do
      post :create, failure: { build_id: @failure.build_id, exception_msg: @failure.exception_msg, is_user_visible: @failure.is_user_visible, notes: @failure.notes, ptfnd_url: @failure.ptfnd_url, resolution_id: @failure.resolution_id, stack_trace: @failure.stack_trace, test: @failure.test }
    end

    assert_redirected_to failure_path(assigns(:failure))
  end

  test "should show failure" do
    get :show, id: @failure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @failure
    assert_response :success
  end

  test "should update failure" do
    put :update, id: @failure, failure: { build_id: @failure.build_id, exception_msg: @failure.exception_msg, is_user_visible: @failure.is_user_visible, notes: @failure.notes, ptfnd_url: @failure.ptfnd_url, resolution_id: @failure.resolution_id, stack_trace: @failure.stack_trace, test: @failure.test }
    assert_redirected_to failure_path(assigns(:failure))
  end

  test "should destroy failure" do
    assert_difference('Failure.count', -1) do
      delete :destroy, id: @failure
    end

    assert_redirected_to failures_path
  end
end
