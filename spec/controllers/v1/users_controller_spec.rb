require 'spec_helper'
require 'rails_helper'

describe V1::UsersController, type: :controller do
  include JSONService::Helpers

  before(:each) do
    10.times do |time|
      user_name = "user#{time}".to_sym
      FactoryGirl.create(user_name)
    end

  @request.host = 'localhost:3000'

  end

  describe 'GET /users' do
    it 'succesfully fetches all Users' do
      expected_users = User.all
      get :index, as: :json
      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body, symbolize_names: true)
      response_users = json_response[:users]
      expect(response_users).to be_instance_of(Array)

      expected_ids = expected_users.pluck(:id)
      expect(expected_ids).to match_ids(response_users)


      expected_keys = %i(id email gravatar_url admin created_at updated_at mailto_url links)
      expect(expected_keys).to match_keys(response_users.first.keys)

    end

  end

  describe 'GET /users/:id' do
    it 'succesfully fetches the requested user' do
      admin = FactoryGirl.create(:admin)
      FactoryGirl.create(:active, creator: admin)
      get :show, params: {id: admin.id}
      expect(response).to have_http_status(:ok)

      response_user = json_response['user']
      expected_keys = %w(id email gravatar_url admin created_at updated_at mailto_url links active_boards)
      expect(expected_keys).to match_keys(response_user.keys)

      expect(admin.id).to eq(response_user['id'])
      expect(admin.email).to eq(response_user['email'])
      expect(admin.gravatar_url).to eq(response_user['gravatar_url'])

      self_link = {'rel' => 'self', 'href' => v1_user_url(admin)}
      expect(self_link).to match_link(response_user['links'])

      boards_link = {'rel' => 'boards', 'href' => v1_user_boards_url(admin)}
      expect(boards_link).to match_link(response_user['links'])
    end

    describe 'when :id is unkown' do
      it 'should respond with :not_found' do
        get :show, params: {id: 'jim'}, as: :json
        expect(response).to have_http_status(:not_found)

        response_error = json_response['error']
        expect(response_error).not_to be_nil

        expect(404).to eq(response_error['status'])
        expect('Not found').to eq(response_error['name'])
        expect(response_error['message']).not_to be_nil


      end

    end

  end

  describe 'POST /users' do

    context "with valid attributes" do
      it "saves the new user in the database" do

        user_attributes = {
              email: 'jim@example.com',
              password: 'secret',
              password_confirmation: 'secret'
          }


        expect {

          post :create, params: {
              user: user_attributes
          }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body, symbolize_names: true)
        response_user = json_response[:user]

        expected_keys = %i( id email gravatar_url admin created_at updated_at mailto_url links active_boards archived_boards )
        expect(expected_keys).to match_keys(response_user.keys)

        expect(user_attributes[:email]).to eq(response_user[:email])
        expect(response_user[:gravatar_url]).to_not be_nil

        expect(response_user[:active_boards]).to be_empty

      end
    end


  end

  describe 'PATCH /users/:id' do

  end

  describe 'DELETE /users/:id' do

  end

end
