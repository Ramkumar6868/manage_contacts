Rails.application.routes.draw do
	root 'contact_lists#index'
	resources :contact_lists do
		get :contacts_for_contact_list 
		post :add_contact
		get :new_contact
	end
	resources :contacts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
