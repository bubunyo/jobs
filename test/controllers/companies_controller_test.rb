require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ERB::Util

  setup do
    @company = FactoryBot.create(:company)
    @user = FactoryBot.create(:user)
    @user.companies << @company
  end

  test "guest users should not be able to register a company" do
    company_params = attributes_for(:company)

    post companies_url, params: {company: company_params}
    assert_redirected_to new_user_session_url

    company = Company.find_by(name: company_params[:name])
    assert company.nil?
  end

  test "should create a new company" do
    company_params = attributes_for(:company)

    sign_in @user
    post companies_url, params: {company: company_params}
    
    company = Company.find_by(name: company_params[:name])

    assert_redirected_to company
    assert company.website     == company_params[:website]
    assert company.description == company_params[:description]

    assert @user.companies.find_by(id: company.id)
  end

  test "should show existing company" do
    get company_url(@company)

    assert_response :ok
    assert_match @company.name,        @response.body
    assert_match @company.industry,    @response.body
    assert_match @company.website,     @response.body
    assert_match @company.description, @response.body
  end

end
