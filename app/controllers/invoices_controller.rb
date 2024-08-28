class InvoicesController < ApplicationController
  before_action :authenticate_user!

	def new
		@invoice = Invoice.new()
	end

	def index
    @invoices = Invoice.all

    if params[:min_amount].present? && params[:max_amount].present?
      min_cents = params[:min_amount].to_f * 100
      max_cents = params[:max_amount].to_f * 100
      @invoices = @invoices.where(amount_cents: min_cents..max_cents)
    end

    @invoices = @invoices.order(emitted_at: :desc).page(params[:page])
  end

	def create
	end

  def new_upload
  end

  def upload
    result = Invoice.import_from_xml(params[:files])
    
    if result[:errors].any?
      flash[:alert] = "Some errors occurred: #{result[:errors].join('; ')}"
    else
      flash[:notice] = "Invoices imported successfully. #{result[:imported]} invoices processed."
    end
    
    redirect_to invoices_path
  end
  

	def show
		# @invoice = Invoice.find(params[:id])
	end

	def provider_invoices
    @provider = Provider.find_by(name: params[:provider_name])
    if @provider
      @invoices = @provider.invoices
      @total_due = @invoices.sum(:amount_cents)
    else
      redirect_to invoices_path, alert: "Provider not found."
    end
  end
end