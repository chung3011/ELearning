Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    devise_for :admins, controllers: {
      sessions: 'admins/sessions',
      passwords: 'admins/passwords',
      registrations: 'admins/registrations'
    }
    get "/admin", to: "admin#index"
    get "/admin/user_info", to: "admin#user_info"
    get "/admin/course_info", to: "admin#course_info"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "auth/:provider/callback", to: "sessions#google_auth"
    get "auth/failure", to: redirect("/")
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/profile", to: "users#show"
    get "/profile/edit", to: "users#edit"
    put "/profile/update", to: "users#update"
    patch "/profile/update", to: "users#update"
    delete "/user/destroy", to: "users#destroy"
    get "/tag/index", to: "tags#index"
    get "/search", to: "home#search"
    get "/courses_list", to: "users#course_list"
    get "/exam_list", to: "users#exam_list"
    get "/result", to: "user_exams#result"
  
    resources :lessons
    resources :courses
    resources :user_courses, only: %i(new create destroy)
    resources :user_lessons, only: %i(new create destroy)
    resources :follow_tags, only: %i(index new create destroy)
    resources :course_comments, only: %i(create destroy)
    resources :course_rates, only: %i(create destroy)
    resources :user_exams, only: %i(create show update)
    resources :questions
    resources :tags
    resources :categories
    resources :account_activation, only: :edit
    resources :password_resets, except: %i(index show destroy)
  end
end
