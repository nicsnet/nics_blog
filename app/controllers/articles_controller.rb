class ArticlesController < InheritedResources::Base

  before_action :authenticate_user!,
    only: [:create, :edit, :update, :destroy]

  def create
    @article = current_user.articles.build(permitted_params[:article])
    create! { collection_path }
  end

  private

  def permitted_params
    params.permit(article: [:title, :content])
  end
end
