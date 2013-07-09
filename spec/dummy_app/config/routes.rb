TheSortableTreeTest::Application.routes.draw do
  get "category/index"

  get "category/manage"

  root :to => 'welcome#index'

  resources :pages do
    collection do
      get  :nested_options
      get  :manage
      get  :node_manage
      get  :expand

      post :rebuild
      post :expand_node
    end
  end

  namespace :admin do
    resources :pages do
      collection do
        get  :nested_options, :manage, :node_manage
        post :rebuild
      end
    end
  end

  resources :article_categories do
    collection do
      get  :manage
      post :rebuild
    end
  end

  namespace :inventory do
    resources :categories do
      collection do
        get  :manage
        post :rebuild
      end
    end
  end

  # resources :comments do
  #   collection do
  #     post :rebuild
  #     get  :manage
  #     get  :comments
  #   end
  # end
end
