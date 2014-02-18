class EasyIssueCopyProjectRelation < ActiveRecord::Base
  unloadable
  belongs_to :project
end
