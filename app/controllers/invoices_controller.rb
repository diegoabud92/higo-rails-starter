class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[show edit update destroy]

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

  def edit
  end

  def new_upload
  end

  def upload
    files = params[:files]

    files.each do |file|
      temp_file_path = Rails.root.join('tmp', file.original_filename)
      File.open(temp_file_path, 'wb') do |f|
        f.write(file.read)
      end

      ImportInvoicesJob.perform_later(temp_file_path.to_s, current_user.id)
    end

    flash[:notice] = "Invoice import jobs have been queued. You can reload the page to see the new invoices."
    redirect_to invoices_path
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
  end

	def show
		@provider = Provider.find(params[:id])
	end

	def provider_invoices
    @provider = Provider.find_by(name: params[:provider_name])
    if @provider
      @invoices = @provider.invoices.order(emitted_at: :desc).page(params[:page]).per(10)
      @total_due = @invoices.sum(:amount_cents)
    else
      redirect_to invoices_path, alert: "Provider not found."
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:uuid, :amount_cents, :currency_code, :emitted_at, :expires_at, :provider_id, :user_id)
  end
end