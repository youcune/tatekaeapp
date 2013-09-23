require 'test_helper'

class PaticipantsControllerTest < ActionController::TestCase
  setup do
    @paticipant = paticipants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paticipants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paticipant" do
    assert_difference('Paticipant.count') do
      post :create, paticipant: { event_id: @paticipant.event_id, name: @paticipant.name }
    end

    assert_redirected_to paticipant_path(assigns(:paticipant))
  end

  test "should show paticipant" do
    get :show, id: @paticipant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paticipant
    assert_response :success
  end

  test "should update paticipant" do
    put :update, id: @paticipant, paticipant: { event_id: @paticipant.event_id, name: @paticipant.name }
    assert_redirected_to paticipant_path(assigns(:paticipant))
  end

  test "should destroy paticipant" do
    assert_difference('Paticipant.count', -1) do
      delete :destroy, id: @paticipant
    end

    assert_redirected_to paticipants_path
  end
end
