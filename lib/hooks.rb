module Redmine_easy_issue_copy
  class Hooks < Redmine::Hook::ViewListener
    def view_issues_show_details_bottom(context)
      context[:controller].send(:render_to_string, {
        :partial => 'easy_issue_copy/show_link',
        :locals => context
      })
    end

    def controller_issues_new_after_save(context)
      if context[:params][:issue][:easy_issue_copy]
        issue = context[:issue]
        EasyIssueCopyIssueRelation.create!(
          original_issue_id: context[:params][:issue][:easy_issue_copy][:original_issue_id].to_i,
          copied_issue_id: issue.id.to_i
        )
      end
    end

    def view_issues_new_top(context)
      if context[:request].params.has_key?("easy_issue_copy")
        context[:controller].send(:render_to_string, {
          :partial => 'easy_issue_copy/copy_header',
          :locals => context
        })
      end
    end

    def view_issues_form_details_bottom(context)
      if context[:request].params.has_key?("easy_issue_copy")
        context[:controller].send(:render_to_string, {
          :partial => 'easy_issue_copy/form',
          :locals => context
        })
      end
    end

  end
end
