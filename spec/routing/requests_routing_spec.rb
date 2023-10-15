require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes to requests#index' do
    expect(get: '/users/1/requests').to route_to('requests#index', user_id: '1')
  end

  it 'routes to requests#new' do
    expect(get: '/users/1/requests/new').to route_to('requests#new', user_id: '1')
  end

  it 'routes to requests#show' do
    expect(get: '/users/1/requests/2').to route_to('requests#show', user_id: '1', id: '2')
  end

  it 'routes to requests#edit' do
    expect(get: '/users/1/requests/2/edit').to route_to('requests#edit', user_id: '1', id: '2')
  end

  it 'routes to requests#create' do
    expect(post: '/users/1/requests').to route_to('requests#create', user_id: '1')
  end

  it 'routes to requests#update via PUT' do
    expect(put: '/users/1/requests/2').to route_to('requests#update', user_id: '1', id: '2')
  end

  it 'routes to requests#update via PATCH' do
    expect(patch: '/users/1/requests/2').to route_to('requests#update', user_id: '1', id: '2')
  end

  it 'routes to requests#destroy' do
    expect(delete: '/users/1/requests/2').to route_to('requests#destroy', user_id: '1', id: '2')
  end

  it 'routes to comments#index' do
    expect(get: '/users/1/requests/2/comments').to route_to('comments#index', user_id: '1', request_id: '2')
  end

  it 'routes to comments#new' do
    expect(get: '/users/1/requests/2/comments/new').to route_to('comments#new', user_id: '1', request_id: '2')
  end

  it 'routes to comments#show' do
    expect(get: '/users/1/requests/2/comments/3').to route_to('comments#show', user_id: '1', request_id: '2', id: '3')
  end

  it 'routes to comments#edit' do
    expect(get: '/users/1/requests/2/comments/3/edit').to route_to('comments#edit', user_id: '1', request_id: '2', id: '3')
  end

  it 'routes to comments#create' do
    expect(post: '/users/1/requests/2/comments').to route_to('comments#create', user_id: '1', request_id: '2')
  end

  it 'routes to comments#update via PUT' do
    expect(put: '/users/1/requests/2/comments/3').to route_to('comments#update', user_id: '1', request_id: '2', id: '3')
  end

  it 'routes to comments#update via PATCH' do
    expect(patch: '/users/1/requests/2/comments/3').to route_to('comments#update', user_id: '1', request_id: '2', id: '3')
  end

  it 'routes to comments#destroy' do
    expect(delete: '/users/1/requests/2/comments/3').to route_to('comments#destroy', user_id: '1', request_id: '2', id: '3')
  end
end
