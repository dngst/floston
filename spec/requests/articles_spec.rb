require 'rails_helper'

RSpec.describe '/articles' do
  let(:admin) { create(:admin) }
  let(:article) { create(:article, admin_id: admin.id) }

  let(:valid_attributes) do
    { title: 'New Article', body: 'Content', admin_id: admin.id }
  end

  let(:new_attributes) do
    { title: 'Updated Article', body: 'New Content', admin_id: admin.id }
  end

  let(:invalid_attributes) do
    { title: '', body: '', admin_id: admin.id }
  end

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get articles_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get article_url(article)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_article_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_article_url(article)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Article' do
        expect do
          post articles_url, params: { article: valid_attributes }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        post articles_url, params: { article: valid_attributes }
        expect(response).to redirect_to(article_url(Article.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Article' do
        expect do
          post articles_url, params: { article: invalid_attributes }
        end.not_to change(Article, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post articles_url, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested article' do
        patch article_url(article), params: { article: new_attributes }
        article.reload
        expect(article.title).to eq('Updated Article')
        expect(article.body).to eq('New Content')
      end

      it 'redirects to the article' do
        patch article_url(article), params: { article: new_attributes }
        expect(response).to redirect_to(article_url(article))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch article_url(article), params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    xit 'destroys the requested article' do
      expect do
        delete article_url(article)
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      delete article_url(article)
      expect(response).to redirect_to(articles_url)
    end
  end
end
