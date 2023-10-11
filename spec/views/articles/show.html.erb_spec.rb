require 'rails_helper'

RSpec.describe 'articles/show' do
  before do
    assign(:article, Article.create!(
                       title: 'Title',
                       body: 'MyText',
                       admin_id: 2,
                       published: false
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end
