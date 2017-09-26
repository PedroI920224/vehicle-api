require 'rails_helper'
include RequestSpecHelper

RSpec.describe 'Todos API', type: :request do
  # initialize test data 
  let!(:vehicles) { create_list(:vehicle, 10) }
  let(:vehicle_id) { vehicles.first.id }

  # Test suite for GET /vehicles
  describe 'GET /vehicles' do
    # make HTTP get request before each example
    before { get '/vehicles' }

    it 'returns vehicles' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200 success' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /vehicles/:id
  describe 'GET /vehicles/:id' do
    before { get "/vehicles/#{vehicle_id}" }

    context 'when the record exists' do
      it 'returns the vehicle' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vehicle_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vehicle_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vehicle with 'id'=100/)
      end
    end
  end

  # Test suite for POST /vehicles
  describe 'POST /vehicles' do
    # valid payload
    let(:valid_attributes) { { brand_car: 'Renault', year: 2001, color: "WHITE", licence_plate: "ABC-135" } }

    context 'when the request is valid' do
      before { post '/vehicles', params: valid_attributes }

      it 'creates a vehicle' do
        expect(json['brand_car']).to eq('Renault')
        expect(json['year']).to eq(2001)
        expect(json['color']).to eq('WHITE')
        expect(json['licence_plate']).to eq('ABC-135')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {brand_car: 'Renault', year: 2001, color: "WHITE" } }
      before { post '/vehicles', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Licence plate can't be blank/)
      end
    end
  end

  # Test suite for PUT /vehicles/:id
  describe 'PUT /vehicles/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/vehicles/#{vehicle_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /vehicles/:id
  describe 'DELETE /vehicles/:id' do
    before { delete "/vehicles/#{vehicle_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
