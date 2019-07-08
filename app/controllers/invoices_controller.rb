class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.select(:invoice_id, :customer_id, :order_id, :sales_person_id, :invoice_date).group(:invoice_id, :customer_id, :order_id, :sales_person_id, :invoice_date).limit(6)
  end

  def show
  end

  def analysis
    @customer_id = 'COM002'
    sales = []
    12.times.each{|i| sales << 0}
    i = Invoice.where(customer_id: @customer_id).limit(200)
    i.each { |record| sales[record.fiscal_month] += record.invoice_price } 
    @result = sales
    @total = @result.each.sum
  end

  def result
    # @data = Daru::Dataframe.from_activerecord(@invoices, )
    @data_frame = Daru::DataFrame.from_activerecord(Invoice.last(50))
  end

  def new
    @invoice = Invoice.new
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.where(:invoice_id => params[:id])
      # @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:customer_id)
    end
end
