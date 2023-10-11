require 'rails_helper'

RSpec.describe 'comments/show' do
  before do
    assign(:comment, Comment.create!(
                       body: 'MyText',
                       request: nil,
                       user: nil
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
