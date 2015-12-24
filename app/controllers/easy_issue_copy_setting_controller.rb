class EasyIssueCopySettingController < ApplicationController
  unloadable
  before_filter :find_project

  def index
  end

  def update
    copy_source_project_id = params[:easy_issue_copy][:project_id]
    if copy_to_project = EasyIssueCopyProjectRelation.where(project_id: @project.id).first
      copy_to_project.update_attributes!(related_project_id: copy_source_project_id)
    else
      EasyIssueCopyProjectRelation.create!(
        project_id: @project.id,
        related_project_id: copy_source_project_id
      )
    end
    redirect_to :controller => 'projects', :action => "settings", :id => @project, :tab => 'easy_issue_copy'
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
