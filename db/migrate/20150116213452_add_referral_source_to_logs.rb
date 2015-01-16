class AddReferralSourceToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :referral_source, :string
  end
end
