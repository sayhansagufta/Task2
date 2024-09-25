class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[edit update destroy]

  def index
    if params[:search].present?
      @employees = Employee.joins(:department).where('employees.name LIKE ? OR departments.name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @employees = Employee.includes(:department).all
    end
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: 'Employee was successfully destroyed.'
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to employees_path, alert: 'Only admin can perform this action.'
    end
  end

  def employee_params
    params.require(:employee).permit(:name, :department_id)
  end
end
