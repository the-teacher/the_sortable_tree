TheSortableTreeTest::Application.routes.draw do
  get "category/index"

  get "category/manage"

  root :to => 'welcome#index'

  resources :article_categories do
    collection do
      get  :manage
      post :rebuild
    end
  end

  resources :pages do
    collection do
      post :rebuild, :expand_node
      get  :manage, :expand
    end
  end

  resources :comments do
    collection do
      post :rebuild
      get  :manage
      get  :comments
    end
  end

  namespace :admin do
    resources :pages do
      collection do
        get  :manage, :first_root_manage, :namespaced_pages
        post :rebuild
      end
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

end
