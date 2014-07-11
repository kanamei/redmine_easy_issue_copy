class EasyIssueCopyIssueRelation < ActiveRecord::Base
  unloadable

  validates :original_issue_id, uniqueness: {scope: :copied_issue_id}
end
