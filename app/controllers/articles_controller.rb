# frozen_string_literal: true

class ArticlesController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :authorize_article_access, only: [:show]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[new create edit update destroy]

  # GET /articles or /articles.json
  def index
    @pagy, @articles = pagy(fetch_articles_for_current_user, items: 20)
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article.mark_as_viewed_by_user(current_user) if user_signed_in?
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    if @article.save
      delete_article_ids_cache
      redirect_to article_url(@article), notice: t('articles.saved')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      delete_article_ids_cache
      redirect_to article_url(@article), notice: t('articles.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    delete_article_ids_cache
    redirect_to articles_url, notice: t('articles.deleted')
  end

  private

  def fetch_articles_for_current_user
    ids = Rails.cache.fetch('article_ids', expires_in: 12.hours) { Article.pluck(:id) }
    query = current_user.admin? ? Article.where(id: ids, user_id: current_user.id) : Article.where(id: ids, user_id: current_user.admin_id, published: true, property_id: current_user.tenant.property_id)
    query.order(created_at: :desc)
  end

  def authorize_article_access
    @article = Article.friendly.find(params[:id])
    return if current_user&.id == @article&.user_id || current_user&.admin_id == @article&.user_id

    flash[:alert] = t('permission_denied')
    redirect_to root_path
  end

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id, :published, :property_id)
  end

  def delete_article_ids_cache
    Rails.cache.delete('article_ids')
  end
end
