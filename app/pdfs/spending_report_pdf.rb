class SpendingReportPdf < Prawn::Document
  def initialize(spendings)
    super()
    @spendings = spendings
    header
    table_content
  end

  def header
    text "Spending Report", size: 30, style: :bold
    move_down 20
  end

  def table_content
    table spending_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.cell_style = { borders: [] }
    end
  end

  def spending_rows
    [['Date', 'Employee', 'Department', 'Value']] +
    @spendings.map do |spending|
      [spending.date, spending.employee.name, spending.department.name, number_to_currency(spending.value)]
    end
  end
end
