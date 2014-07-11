class EasyIssueCopyProjectRelation < ActiveRecord::Base
  unloadable
  belongs_to :internal_project, class_name: 'Project', foreign_key: 'project_id'
  belongs_to :external_project, class_name: 'Project', foreign_key: 'related_project_id'
end
