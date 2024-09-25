class ReportsController < ApplicationController
    before_action :authenticate_user!
    def index
      @spendings = Spending.where('date >= ?', Date.new(2020))
      @spendings = @spendings.where('value >= ?', params[:value_filter]) if params[:value_filter].present?
  
      respond_to do |format|
        format.html
        format.xls { send_data @spendings.to_xls, filename: 'report.xls' }
        format.pdf do
          pdf = SpendingReportPdf.new(@spendings)
          send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
        end
      end
    end
  end
  