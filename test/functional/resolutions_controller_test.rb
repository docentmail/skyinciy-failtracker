require 'test_helper'

class ResolutionsControllerTest < ActionController::TestCase
  setup do
    @resolution = resolutions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resolutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resolution" do
    assert_difference('Resolution.count') do
      post :create, resolution: { application: @resolution.application, exception_msg_ptrn: @resolution.exception_msg_ptrn, is_resolved: @resolution.is_resolved, jira_url: @resolution.jira_url, notes: @resolution.notes, problem_type: @resolution.problem_type, stack_trace_ptrn: @resolution.stack_trace_ptrn, test: @resolution.test }
    end

    assert_redirected_to resolution_path(assigns(:resolution))
  end

  test "should show resolution" do
    get :show, id: @resolution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resolution
    assert_response :success
  end

  test "should update resolution" do
    put :update, id: @resolution, resolution: { application: @resolution.application, exception_msg_ptrn: @resolution.exception_msg_ptrn, is_resolved: @resolution.is_resolved, jira_url: @resolution.jira_url, notes: @resolution.notes, problem_type: @resolution.problem_type, stack_trace_ptrn: @resolution.stack_trace_ptrn, test: @resolution.test }
    assert_redirected_to resolution_path(assigns(:resolution))
  end

  test "should destroy resolution" do
    assert_difference('Resolution.count', -1) do
      delete :destroy, id: @resolution
    end

    assert_redirected_to resolutions_path
  end
end
