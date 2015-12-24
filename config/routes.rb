# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :projects do
    match "easy_issue_copy/setting", :to => "easy_issue_copy_setting#update", :via => [:post, :put, :patch]
    match "easy_issue_copy", :to => "easy_issue_copy_setting#post", :via => [:post, :put, :patch]
  end

  resources :issues do
    match "easy_issue_copy/link", :to => "issue_link#link", :via => [:post, :put, :patch]
  end
end
