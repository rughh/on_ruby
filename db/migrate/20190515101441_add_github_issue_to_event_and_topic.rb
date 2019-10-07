# frozen_string_literal: true

class AddGithubIssueToEventAndTopic < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :github_issue, :integer
    add_column :topics, :github_issue, :integer
  end
end
