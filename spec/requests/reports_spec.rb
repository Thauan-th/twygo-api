# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'reports', type: :request do
  let(:course) { create(:course) }

  path '/courses/{course_id}/reports' do
    post 'Creates a report for a specific course' do
      tags 'Reports'
      description 'Creates a new report for a specific course. The report will be available soon.'
      parameter name: :course_id, in: :path, type: :string, description: 'Course ID', required: true

      response '200', 'Report created successfully' do
        let(:course_id) { course.id }
        schema type: :object,
               properties: {
                 message: { type: :string },
                 report_id: { type: :integer }
               },
               required: %w[message report_id]

        run_test! do
          expect(JSON.parse(response.body)['message']).to eq('Report will be available soon')
          expect(JSON.parse(response.body)['report_id']).to be_an(Integer)
        end
      end

      response '404', 'Invalid course ID' do
        let(:course_id) { '999' }
        run_test! do
          expect(JSON.parse(response.body)['error']).to eq('Course not found')
        end
      end
    end

    get 'Lists all reports by course' do
      tags 'Reports'
      description 'Lists all reports for a specific course.'

      parameter name: :course_id, in: :path, type: :string, description: 'Course ID', required: true

      response '200', 'Reports listed successfully' do
        let(:course_id) { course.id }

        schema type: :object,
               properties: {
                 results: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       created_at: { type: :string, format: 'date-time' },
                       updated_at: { type: :string, format: 'date-time' },
                       file: { type: :string }
                     },
                     required: %w[id created_at updated_at file]
                   }
                 }
               },
               required: ['results']

        run_test! do
          expect(JSON.parse(response.body)['results']).to be_an(Array)
        end
      end

      response '404', 'Invalid course ID' do
        let(:course_id) { '999' }
        run_test! do
          expect(JSON.parse(response.body)['error']).to eq('Course not found')
        end
      end
    end
  end
end
