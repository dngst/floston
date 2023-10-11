require 'rails_helper'

RSpec.describe 'articles/edit' do
  let(:article) do
    Article.create!(
      title: 'MyString',
      body: 'MyText',
      admin_id: 1,
      published: false
    )
  end

  before do
    assign(:article, article)
  end

  it 'renders the edit article form' do
    render

    assert_select 'form[action=?][method=?]', article_path(article), 'post' do
      assert_select 'input[name=?]', 'article[title]'

      assert_select 'textarea[name=?]', 'article[body]'

      assert_select 'input[name=?]', 'article[admin_id]'

      assert_select 'input[name=?]', 'article[published]'
    end
  end
end
