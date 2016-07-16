require 'test_helper'

class ComplaintsControllerTest < ActionController::TestCase
  setup do
    @complaint = complaints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:complaints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create complaint" do
    assert_difference('Complaint.count') do
      post :create, complaint: { People: @complaint.People, address: @complaint.address, body: @complaint.body, category_id: @complaint.category_id, city: @complaint.city, latitude: @complaint.latitude, likes: @complaint.likes, longitude: @complaint.longitude, title: @complaint.title, user_id: @complaint.user_id }
    end

    assert_redirected_to complaint_path(assigns(:complaint))
  end

  test "should show complaint" do
    get :show, id: @complaint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @complaint
    assert_response :success
  end

  test "should update complaint" do
    patch :update, id: @complaint, complaint: { People: @complaint.People, address: @complaint.address, body: @complaint.body, category_id: @complaint.category_id, city: @complaint.city, latitude: @complaint.latitude, likes: @complaint.likes, longitude: @complaint.longitude, title: @complaint.title, user_id: @complaint.user_id }
    assert_redirected_to complaint_path(assigns(:complaint))
  end

  test "should destroy complaint" do
    assert_difference('Complaint.count', -1) do
      delete :destroy, id: @complaint
    end

    assert_redirected_to complaints_path
  end
end
