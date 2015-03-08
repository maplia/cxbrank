crumb :root do
  link APP_INFO[:name], root_path
end

crumb :musics do
  link '登録曲リスト', musics_path
  parent :root
end

crumb :skills do
  link 'ランクポイント表', skills_path
  parent :root
end

crumb :edit_skill do
  link 'ランクポイント編集', edit_skill_path
  parent :skills
end

crumb :confirm_skill do
  link 'ランクポイント編集確認', confirm_skill_path
  parent :skills
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).