require File.expand_path('../../test_helper', __FILE__)

class IssuesControllerTest < Redmine::IntegrationTest
  fixtures :users, :projects, :trackers, :issue_statuses, :projects_trackers, :enumerations, :roles, :members, :member_roles, :issues

  def setup
    User.current = nil
  end

  def test_only_admin_should_see_deleted_at_filter
    post '/login', :username => 'admin', :password => 'admin'
    get issues_path

    assert_response :success
    byebug
    assert_select 'select#add_filter_select' do
      assert_select 'option[value=deleted_at]'
    end
    assert_select 'table.issues'
    assert_select 'table.list tr', 4
  end

  # def test_not_admin_should_not_see_deleted_at_filter
  #   @request.session[:user_id] = 2
  #   get :index
  #   assert_response :success
  #   assert_select 'select#add_filter_select' do
  #     assert_select 'option[value=deleted_at]', false
  #   end
  #   assert_select 'table.issues'
  #   assert_select 'table.list tr', 4
  # end

  # def test_only_admin_should_see_deleted_issue
  #   @request.session[:user_id] = 1 # admin
  #   # issue = issues(:issues_001)
  #   # issue.delete
  #   get :show, :id => 1
  #   byebug
  #   assert_response :success
  # end

  # def test_not_admin_should_not_see_deleted_issue
  #   @request.session[:user_id] = 2
  #   # issue = issues(:issues_001)
  #   # issue.delete
  #   get :show, :id => 1
  #   assert_response :missing
  # end
end
