require 'rails_helper'

RSpec.describe 'requests/show' do
  before do
    assign(:request, Request.create!(
                       title: 'Title',
                       description: 'MyText',
                       user: nil
                     ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
