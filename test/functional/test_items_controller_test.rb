require 'test_helper'

class TestItemsControllerTest < ActionController::TestCase
  setup do
    @test_item = test_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_item" do
    assert_difference('TestItem.count') do
      post :create, test_item: { integer: @test_item.integer, string: @test_item.string }
    end

    assert_redirected_to test_item_path(assigns(:test_item))
  end

  test "should show test_item" do
    get :show, id: @test_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_item
    assert_response :success
  end

  test "should update test_item" do
    put :update, id: @test_item, test_item: { integer: @test_item.integer, string: @test_item.string }
    assert_redirected_to test_item_path(assigns(:test_item))
  end

  test "should destroy test_item" do
    assert_difference('TestItem.count', -1) do
      delete :destroy, id: @test_item
    end

    assert_redirected_to test_items_path
  end
end
