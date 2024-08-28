class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      redirect_to @provider, notice: 'Provider was successfully created.'
    else
      render :new
    end
  end

  def index
    @providers = Provider.page(params[:page]).per(10)
  end

  def show
    @provider = Provider.find(params[:id])
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :email, :phone_number)
  end
end
