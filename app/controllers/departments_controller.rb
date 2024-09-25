class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[edit update destroy]

  def index
    @departments = Department.all
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to departments_path, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to departments_path, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_path, notice: 'Department was successfully destroyed.'
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def authorize_admin!
    unless current_user.admin?
      redirect_to departments_path, alert: 'Only admin can perform this action.'
    end
  end

  def department_params
    params.require(:department).permit(:name)
  end
end