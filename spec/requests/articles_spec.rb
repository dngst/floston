require 'rails_helper'

RSpec.describe '/articles' do
  let(:admin) { create(:admin) }
  let(:user) { create(:user, admin_id: admin.id) }
  let(:article) { create(:article, user_id: admin.id) }

  let(:valid_attributes) do
    { title: 'New Article', body: 'Content', user_id: admin.id }
  end

  let(:new_attributes) do
    { title: 'Updated Article', body: 'New Content', user_id: admin.id }
  end

  let(:invalid_attributes) do
    { title: '', body: '', user_id: admin.id }
  end

  before do
    user
    admin
    article
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      sign_in admin

      get articles_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      sign_in admin

      get article_url(article)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      sign_in admin

      get new_article_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      sign_in admin

      get edit_article_url(article)
      expect(response).to be_successful
    end

    it 'requires admin access' do
      sign_in user

      get edit_article_url(article)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You do not have permission to access that page')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Article' do
        sign_in admin

      end

      it 'redirects to the created article' do
        sign_in admin

        post articles_url, params: { article: valid_attributes }
        expect(response).to redirect_to(article_url(Article.last))
      end

      it 'requires admin access' do
        sign_in user

        post articles_url, params: { article: valid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You do not have permission to access that page')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Article' do
        sign_in admin

        expect do
          post articles_url, params: { article: invalid_attributes }
        end.not_to change(Article, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        sign_in admin

        post articles_url, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested article' do
        sign_in admin

        patch article_url(article), params: { article: new_attributes }
        article.reload
        expect(article.title).to eq('Updated Article')
        expect(article.body).to eq('New Content')
      end

      it 'redirects to the article' do
        sign_in admin

        patch article_url(article), params: { article: new_attributes }
        expect(response).to redirect_to(article_url(article))
      end

      it 'requires admin access' do
        sign_in user

        patch article_url(article), params: { article: new_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You do not have permission to access that page')
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        sign_in admin

        patch article_url(article), params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested article' do
      sign_in admin

      expect do
        delete article_url(article)
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      sign_in admin

      delete article_url(article)
      expect(response).to redirect_to(articles_url)
    end

    it 'requires admin access' do
      sign_in user

      delete article_url(article)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You do not have permission to access that page')
    end
  end
end
