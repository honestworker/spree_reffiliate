module Spree::Admin::ReferralSettingsController < ResourceController
  def self.prepended(base)
    before_action :check_credit_amount, only: :update
  end

  def update
    Spree::Config[:referrer_benefit_enabled] = params[:referrer_benefit_enabled] == '1'
    Spree::Config[:referral_credits] = params[:referral_credits]
    flash[:success] = Spree.t(:successful, scope: "referral_settings.update")
    redirect_to edit_admin_referral_settings_path
  end

  private

  def check_credit_amount
    if params[:referral_credits].to_f < 0
      flash[:error] = Spree.t(:unsuccessful, scope: "referral_settings.update")
      redirect_to edit_admin_referral_settings_path
    end
  end
end

Spree::Admin::ReferralSettingsController.prepend Spree::Admin::ReferralSettingsControllerDecorator