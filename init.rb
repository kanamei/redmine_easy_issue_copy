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
  author 'Tatsuhiko Shimomura'
  description 'This plugin enable copy ticket between related project. Project can relate by project setting.'
  version '1.0.0'
  url 'https://github.com/shim0mura/redmine_easy_issue_copy'
  author_url 'https://github.com/shim0mura/'
  project_module :easy_issue_copy do
    permission :set_copy_relation, :setting => [:index, :update]
  end
  # menu :project_menu, :easy_issue_copy, { :controller => 'setting', :action => 'index'}, :param => :project_id
end
