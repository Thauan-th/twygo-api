require 'rails_helper'

RSpec.describe PdfGenerator do
  describe '#initialize' do
    let(:report) { create(:report) }
    let(:pdf_generator) { described_class.new(report.id) }

    it 'assigns the report' do
      expect(pdf_generator.report).to eq(report)
    end

    it 'should raise an error if the report does not exist' do
      expect { described_class.new(0) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#generate_and_save_pdf' do
    let(:report) { create(:report) }
    let(:pdf_generator) { described_class.new(report.id) }

    it 'generates a PDF file' do
      expect { pdf_generator.generate_and_save_pdf }.to change { report.reload.file.attached? }.from(false).to(true)
    end
  end
end
