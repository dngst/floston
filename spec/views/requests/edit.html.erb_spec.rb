require 'rails_helper'

RSpec.describe 'requests/edit' do
  let(:request) do
    Request.create!(
      title: 'MyString',
      description: 'MyText',
      user: nil
    )
  end

  before do
    assign(:request, request)
  end

  it 'renders the edit request form' do
    render

    assert_select 'form[action=?][method=?]', request_path(request), 'post' do
      assert_select 'input[name=?]', 'request[title]'

      assert_select 'textarea[name=?]', 'request[description]'

      assert_select 'input[name=?]', 'request[user_id]'
    end
  end
end
