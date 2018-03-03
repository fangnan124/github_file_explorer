Rails.application.routes.draw do
  root "files_explorer#index"
  get "files_explorer" => "files_explorer#index", as: :files_explorer
end
