class ChangeReferralSourceOnLogs < ActiveRecord::Migration
  def change
    change_column :logs, :referral_source, :text
  end
end
