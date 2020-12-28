Rails.application.routes.draw do
  devise_for :users,path:'',path_names:{sign_in:'login',sign_out:'logout',sign_up:'register'}
  resources :notes do
  	member do
  		get :toggle_status
  	end
  end
   get 'draft',:to => 'notes#draft'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
