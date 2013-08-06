class AddProposalTypeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :proposal_type, :string, :default => 'proposal'
  end
end
