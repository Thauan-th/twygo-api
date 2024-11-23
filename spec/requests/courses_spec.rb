# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'courses', type: :request do
  path '/courses' do
    get('list courses') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create course') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: 'date' },
          end_date: { type: :string, format: 'date' },
          image: { type: :string, format: 'binary' }
        },
        required: %w[title description start_date]
      }

      let(:course) do
        {
          title: 'Course Title',
          description: 'Course Description',
          start_date: '2024-01-01',
          end_date: '2024-12-31'
        }
      end

      response(201, 'created') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'Course ID'

    get('show course') do
      response(200, 'successful') do
        let(:id) { create(:course).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update course') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: 'date' },
          end_date: { type: :string, format: 'date' },
          image: { type: :string, format: 'binary' }
        },
        required: %w[title description start_date]
      }

      response(200, 'successful') do
        let(:id) { create(:course).id }
        let(:course) { { title: 'Updated Course Title', description: 'Updated Description' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update course') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_date: { type: :string, format: 'date' },
          end_date: { type: :string, format: 'date' },
          image: { type: :string, format: 'binary' }
        },
        required: %w[title description start_date]
      }

      response(200, 'successful') do
        let(:id) { create(:course).id }
        let(:course) { { title: 'Updated Course Title', description: 'Updated Description' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete course') do
      produces 'application/json'
      consumes 'application/json'

      response(204, 'successful') do
        let(:id) { create(:course).id }

        run_test! do
          expect(response.body).to be_empty
          expect(Course.find_by(id: id)).to be_nil
        end
      end
    end
  end

  path '/courses/{id}/lessons' do
    parameter name: 'id', in: :path, type: :string, description: 'Course ID'

    get('list lessons') do
      response(200, 'successful') do
        let(:id) { create(:course, :with_lessons).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create lesson') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :lesson, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          video: { type: :string }
        },
        required: %w[title description]
      }

      response(201, 'created') do
        let(:id) { create(:course).id }
        let(:lesson) do
          {
            title: 'Lesson Title',
            description: 'Lesson Description',
            video: 'https://www.youtube.com/watch?v=123456'
          }
        end

        run_test! do
          expect(Lesson.last.title).to eq('Lesson Title')
          expect(Lesson.last.description).to eq('Lesson Description')
          expect(Lesson.last.course).to eq(Course.find_by(id: id))
        end
      end
    end
  end
end
