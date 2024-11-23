# frozen_string_literal: true

class PdfGenerator
  attr_accessor :report, :lessons

  def initialize(report_id)
    self.report = fetch_report(report_id)
    self.lessons = report.course.lessons
  end

  def generate_and_save_pdf
    Tempfile.create(["#{report.id}_report_#{timestamp}", '.pdf']) do |tempfile|
      tempfile.binmode
      tempfile.write(generate_pdf)
      tempfile.rewind
      report.update(file: tempfile)
    end
  end

  private

  def generate_pdf
    pdf = Prawn::Document.new(page_size: 'A4') do |doc|
      doc.text "Relatório do Curso - #{report.course.title}", size: 16, style: :bold, align: :center
      doc.move_down 20

      doc.text "Data do Relatório: #{Time.now.strftime('%d/%m/%Y %H:%M')}", size: 10, align: :right
      doc.move_down 10

      doc.text 'Informações Gerais:', size: 10, style: :bold
      doc.move_down 5

      doc.table(generate_table_data, header: true, row_colors: %w[F0F0F0 FFFFFF], width: doc.bounds.width) do
        row(0).font_style = :bold
        row(0).background_color = 'D3D3D3'
        columns(1).align = :center
      end
    end

    pdf.render
  end

  def generate_table_data
    [
      ['Descrição', 'Valor'],
      ['Total de Aulas', lessons_count],
      ['Total de Vídeos', report.lessons_video_count],
      ['Tamanho dos Vídeos (MB)', report.lessons_video_size_in_megabytes],
      ['Aulas Criadas na Última Semana', lessons_created_on_last_week],
      ['Aulas Criadas no Último Mês', lessons_created_on_last_month]
    ]
  end

  def lessons_count
    lessons.size
  end

  def lessons_created_on_last_week
    lessons_created_since(1.week.ago)
  end

  def lessons_created_on_last_month
    lessons_created_since(1.month.ago)
  end

  def lessons_created_since(date)
    lessons.where('created_at >= ?', date).count
  end

  def fetch_report(id)
    Report.includes(course: :lessons).find(id)
  end

  def timestamp
    Time.now.strftime('%Y%m%d%H%M%S')
  end
end
