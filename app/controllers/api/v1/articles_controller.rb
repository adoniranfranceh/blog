class Api::V1::ArticlesController < ActionController::API
  def index
    @articles = Article.all
  end
end
