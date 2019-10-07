# frozen_string_literal: true

class AddProposalTypeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :proposal_type, :string, :default => 'proposal'
  end
end
