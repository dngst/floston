class ArticlesController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :authorize_article_access, only: [:show]
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[new create edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = if current_user&.admin?
                  Article.where(admin_id: current_user.id).order(created_at: :desc).page(params[:page])
                else
                  Article.where(admin_id: current_user.admin_id).order(created_at: :desc).page(params[:page])
                end
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def authorize_article_access
    @article = Article.friendly.find(params[:id])
    return if current_user&.id == @article&.admin_id || current_user&.admin_id == @article&.admin_id

    flash[:alert] = 'You do not have permission to access this page.'
    redirect_to root_path
  end

  def set_article
    @article = Article.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :admin_id, :published)
  end
end