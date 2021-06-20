class Admin::FundsController < ApplicationController
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Funds
      name  = Fund.arel_table[:name]
      @funds = Fund.where(name.matches("%#{@keywords}%"))
    end
    @funds = @funds.order(created_at: :desc).page params[:page]
    render "admin/funds/index"
  end

  def index
    @funds = Fund.all
    @funds = @funds.order(created_at: :desc).page params[:page]
  end

  def show
    @fund = Fund.find(params[:id])
  end

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.create(fund_params)
    redirect_to admin_funds_path
  end

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    @fund = Fund.find(params[:id])
    @fund.update(fund_params)
    redirect_to admin_fund_path(@fund)
  end

  def fund_params
    params.require(:fund).permit(
      :name)
  end
end