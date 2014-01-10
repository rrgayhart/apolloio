class ApiAccountsController < ApplicationController
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
    params.require(:api_account).permit(:id, :user_id, :api_id, :api_username)
  end
end
