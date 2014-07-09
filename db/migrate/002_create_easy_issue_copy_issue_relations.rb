class CreateEasyIssueCopyIssueRelations < ActiveRecord::Migration
  def change
    create_table :easy_issue_copy_issue_relations do |t|
      t.integer :original_issue_id
      t.integer :copied_issue_id
    end
  end
end
