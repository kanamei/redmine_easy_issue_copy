module EasyIssueCopyProjectsHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, ProjectsHelperMethodsEasyIssueCopy)

    base.class_eval do
      unloadable
      alias_method_chain :project_settings_tabs, :easy_issue_copy
    end

  end
end

module ProjectsHelperMethodsEasyIssueCopy
  def project_settings_tabs_with_easy_issue_copy
    tabs = project_settings_tabs_without_easy_issue_copy
    action = {:name => 'easy_issue_copy', :controller => 'setting', :action => :index, :partial => 'setting/index', :label => :easy_issue_copy}

    tabs << action if User.current.allowed_to?(action, @project)
    tabs
  end
end
