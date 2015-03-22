crumb :root do
  link APP_INFO[:name], root_url
end

crumb :users do
  link '登録ユーザーリスト', users_url
  parent :root
end

crumb :new_user do
  link 'ユーザー登録', new_user_url
  parent :root
end

crumb :confirm_new_user do
  link 'ユーザー登録確認', confirm_new_users_url
  parent :root
end

crumb :create_user do
  link 'ユーザー登録完了', user_url
  parent :root
end

crumb :musics do
  link '登録曲リスト', musics_url
  parent :root
end

crumb :border do
  link 'ボーダー表', border_index_url
  parent :root
end

crumb :show_border do
  link '曲別', border_path
  parent :border
end

crumb :skills do
  link 'ランクポイント表', skills_url
  parent :root
end

crumb :edit_skill do
  link 'ランクポイント編集', edit_skill_url
  parent :skills
end

crumb :confirm_skill do
  link 'ランクポイント編集確認', confirm_skill_url
  parent :skills
end

crumb :edit_user do
  link 'ユーザー登録', edit_user_url
  parent :skills
end

crumb :confirm_edit_user do
  link 'ユーザー登録確認', confirm_edit_user_url
  parent :skills
end

crumb :view do
  link 'ランクポイント表', view_url
  parent :root
end

crumb :iglock do
  link 'ランクポイント表 [ロック状態無視]', iglock_url
  parent :root
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).