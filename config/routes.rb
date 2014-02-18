# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :projects do
    post "easy_issue_copy/setting", :to => "setting#update"
    post "easy_issue_copy", :to => "setting#pos"
  end
end
