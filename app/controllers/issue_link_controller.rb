class IssueLinkController < ApplicationController
  unloadable
  before_filter :find_issue
  before_filter :is_project_already_linked?

  def link
    @internal_issue.description = @internal_issue.description + "\n元チケット: \##{@external_issue.id}"
    @internal_issue.save!

    EasyIssueCopyIssueRelation.create!(
      original_issue_id: @external_issue.id,
      copied_issue_id: @internal_issue.id
    )

    flash[:notice] = "チケットを関連付けました。"
    redirect_to issue_path(params[:issue_id])
  end

  private
  def find_issue
    @internal_issue = Issue.find(params[:issue_id])
    @external_issue = Issue.find(params["easy_issue_copy"]["external_issue_id"])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "関連付けようとしているチケットが存在しません。"
    redirect_to issue_path(params[:issue_id])
    return false
  end

  def is_project_already_linked?
    @linked_project = EasyIssueCopyProjectRelation.where(
      project_id: @internal_issue.project_id,
      related_project_id: @external_issue.project_id
    )
    if @linked_project.empty?
      flash[:error] = "プロジェクトが関連していません。"
      redirect_to issue_path(params[:issue_id])
      return false
    end
  end

end
