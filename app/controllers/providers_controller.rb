class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]

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

  def edit
  end

  def update
    if @provider.update(provider_params)
      redirect_to @provider, notice: 'Provider was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @provider.destroy
    redirect_to providers_url, notice: 'Provider was successfully destroyed.'
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :email, :phone_number)
  end
end
