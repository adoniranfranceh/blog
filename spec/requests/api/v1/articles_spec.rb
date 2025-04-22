require 'rails_helper'

RSpec.describe 'Articles' do
  let(:user) { User.create(email: 'x@x.com', password: 123456) }
  let(:header) { http_basic_auth_header }
  before(:each, signed_in: true) { sign_in(user) }
  before(:each) { Article.create(title: 'art 1', content: 'conteudo do art 1') }

  describe 'GET /api/v1/articles' do
    context 'with http basic auth header' do
      it 'responds with status Ok' do
        get '/api/v1/articles.json', headers: header

        expect(response).to have_http_status(:ok)
      end

      it 'responds with correct persisted article json' do
        get '/api/v1/articles.json', headers: header

        expect(json_to_hash(response.body)[:data].first).not_to have_key(:created_at)
        expect(json_to_hash(response.body)[:data].first).not_to have_key(:updated_at)
        expect(response.body).to include('art 1')
        expect(response.body).to include('conteudo do art 1')
      end
    end

    context 'with session', signed_in: true do
      it 'responds with correct persisted article json' do
        get '/api/v1/articles.json'

        expect(json_to_hash(response.body)[:data].first).not_to have_key(:created_at)
        expect(json_to_hash(response.body)[:data].first).not_to have_key(:updated_at)
        expect(response.body).to include('art 1')
        expect(response.body).to include('conteudo do art 1')
      end

      it 'after expires' do
        user.update(session_expires_at: 1.second.ago)

        get '/api/v1/articles.json'

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq '{}'
      end
    end
  end
end
