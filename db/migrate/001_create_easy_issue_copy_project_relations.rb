class CreateEasyIssueCopyProjectRelations < ActiveRecord::Migration
  def change
    create_table :easy_issue_copy_project_relations do |t|
      t.integer :project_id
      t.integer :related_project_id
    end
  end
end
