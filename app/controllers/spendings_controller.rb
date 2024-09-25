class SpendingsController < ApplicationController
  before_action :set_spending, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[edit update destroy]

  def index
    @spendings = Spending.includes(:employee, :department).order(value: :asc)
    # If searching by employee or department name
    if params[:search].present?
      @spendings = @spendings.joins(:employee, :department)
                             .where('employees.name LIKE ? OR departments.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
  end
  
  def download_excel
    @spendings = Spending.all
    respond_to do |format|
      format.xlsx { render xlsx: 'spendings', filename: 'spendings.xlsx' }
    end
  end
  
  def download_pdf
    @spendings = Spending.all
    pdf = Prawn::Document.new
    pdf.text 'Spending Report'
    pdf.table @spendings.map { |s| [s.date, s.value] }
    send_data pdf.render, filename: 'spendings.pdf', type: 'application/pdf'
  end
  

  def new
    @spending = Spending.new
  end

  def create
    @spending = Spending.new(spending_params)
    if @spending.save
      redirect_to spendings_path, notice: 'Spending was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @spending.update(spending_params)
      redirect_to spendings_path, notice: 'Spending was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @spending.destroy
    redirect_to spendings_path, notice: 'Spending was successfully destroyed.'
  end

  private

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to spendings_path, alert: 'Only admin can perform this action.'
    end
  end

  def spending_params
    params.require(:spending).permit(:date, :value, :employee_id, :department_id)
  end
end
