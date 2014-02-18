require 'easy_issue_copy_projects_helper_patch'
# require 'easy_issue_copy_button'
require_dependency 'hooks'

Rails.configuration.to_prepare do
  unless ProjectsHelper.included_modules.include? EasyIssueCopyProjectsHelperPatch
    ProjectsHelper.send(:include, EasyIssueCopyProjectsHelperPatch)
  end
end

Redmine::Plugin.register :redmine_easy_issue_copy do
  name 'Redmine Easy Issue Copy plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  project_module :easy_issue_copy do
    permission :set_copy_relation, :setting => [:index, :update]
  end
  # menu :project_menu, :easy_issue_copy, { :controller => 'setting', :action => 'index'}, :param => :project_id
end
