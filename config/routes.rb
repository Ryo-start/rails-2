Rails.application.routes.draw do
  devise_for :users

  # プロフィール編集と更新のルート
  get 'profile/edit', to: 'user#edit_profile', as: 'edit_profile'
  patch 'profile/update', to: 'user#update_profile', as: 'profile_update'

  # アプリケーションのトップページ（ルート）を指定
  root to: "user#index"
  resources :reservations
  
  # 他のリソース
  resources :rooms do
    collection do
      get 'search'  # search アクションへのルートを作成
    end

    resources :reservations do
      member do
        patch :confirm  # 確定処理用のルートを追加
      end
    end
  end
  
end





# devise_for :users
# deviseを使ってユーザー認証のルートを設定します。これにより、ユーザー登録やログインなどの機能が自動的に提供されます。

# get 'profile/edit', to: 'home#edit_profile', as: 'edit_profile'
# プロフィール編集ページのルートを設定します。home#edit_profileというアクションに対応しており、edit_profile_pathという名前付きルートが作成されます。

# patch 'profile/update', to: 'home#update_profile', as: 'profile_update'
# プロフィールの更新処理を行うルートを設定します。patchメソッドは、主にリソースの更新に使われます。このルートに対応するアクションはhome#update_profileです。

# root to: "home#index"
# アプリケーションのトップページ（ルート）を指定します。ここでは、home#indexアクションがトップページとして設定されています。

# resources :rooms
# roomsリソースのための標準的なRESTfulルートを作成します。index, show, new, edit, create, update, destroyなど、roomsに対する操作を管理できます。(searchは含まれない)

# resources :reservations
# roomsの内部にreservationsリソースをネストしています。これにより、予約（reservations）は特定の部屋（rooms）に関連付けられる形になります。

# member do
# reservationsリソースに対して個別の操作を追加します。patch :confirmというルートを定義しており、confirmアクションを予約に対して実行できるようにします。confirmアクションは予約の確定処理に使われると考えられます。
