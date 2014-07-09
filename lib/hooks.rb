module Redmine_easy_issue_copy
  class Hooks < Redmine::Hook::ViewListener
    def view_issues_show_details_bottom(context)
      context[:controller].send(:render_to_string, {
        :partial => 'easy_issue_copy/form',
        :locals => context
      })
    end

    def controller_issues_new_after_save(context)
      issue = context[:issue]
      EasyIssueCopyIssueRelation.create!(
        original_issue_id: context[:params][:issue][:easy_issue_copy][:parent_id].to_i,
        copied_issue_id: issue.id.to_i
      )
    end
  
    def controller_issues_new_before_save(context)
      if context[:params][:issue][:easy_issue_copy]
        issue = Issue.find(context[:params][:issue][:easy_issue_copy][:original_issue_id])
        original_watcher_user_ids = issue.watchers ? issue.watchers.map{|watcher| watcher.user_id} : []
        project_member_ids = context[:project].members.map{|member| member.user_id}
        inherit_watcher_user_ids = original_watcher_user_ids.select do |user_id|
          project_member_ids.include?(user_id)
        end
        User.where(id: inherit_watcher_user_ids).each do |user|
          context[:issue].add_watcher(user)
        end
      end 
    end
  end
end
