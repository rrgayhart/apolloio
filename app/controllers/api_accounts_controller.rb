class ApiAccountsController < ApplicationController

  def index
    @api_account = ApiAccount.new
    @api_accounts = current_user.api_accounts
    @github_api_id = Api.find_by(provider: "Github").id
    @fitbit_api_id = Api.find_by(provider: "Fitbit").id
    @exercism_api_id = Api.find_by(provider: "Exercism").id
  end

  def create
    api_account_data = api_account_params
    api_account_data[:user_id] = current_user.id
    new_apiaccount = ApiAccount.new(api_account_data)
    if new_apiaccount.is_valid_user? && new_apiaccount.save
      flash[:added_api] = "Added API Account"
      redirect_to :back
    elsif !new_apiaccount.is_valid_user?
      flash[:no_apis] = "API Username Is Not Valid."
      redirect_to api_accounts_path
    else
      flash[:no_apis] = "Api Account Unsuccessfully Created."
      redirect_to api_accounts_path
    end
  end

  def show
    @api_account = current_user.api_accounts.where(id: params[:id]).first
    if @api_account
      @provider = @api_account.api.provider
    else
      redirect_to dashboard_path
    end
  end

private

  def api_account_params
    params.require(:api_account).permit(:id, :api_id, :api_username)
  end

end
