require 'rails_helper'

RSpec.describe 'articles/new' do
  before do
    assign(:article, Article.new(
                       title: 'MyString',
                       body: 'MyText',
                       admin_id: 1,
                       published: false
                     ))
  end

  it 'renders new article form' do
    render

    assert_select 'form[action=?][method=?]', articles_path, 'post' do
      assert_select 'input[name=?]', 'article[title]'

      assert_select 'textarea[name=?]', 'article[body]'

      assert_select 'input[name=?]', 'article[admin_id]'

      assert_select 'input[name=?]', 'article[published]'
    end
  end
end
