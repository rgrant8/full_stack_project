namespace :search_suggestions do
  desc "Generate search suggestions from lists"
  task :index => :environment do
    SearchSuggestion.index_lists
  end
end