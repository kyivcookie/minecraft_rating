class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments/callback
  def callback
    raise params.inspect
  end

  # POST /payments
  # POST /payments.json
  def create
    # https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business=alialhaulani-facilitator@ukr.net&item_name='+server_id+'&item_number=unrealm&amount='+price+'&quantity='+input+'&currency_code=USD&return=http://minecraftservers-ip.com/callback.php&rm=2

   redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business=alialhaulani-facilitator@ukr.net&item_name=#{params[:payment][:server_id]}&item_number=unrealm&amount=#{50}&quantity=#{params[:payment][:quantity]}&currency_code=USD&return=#{callback_url}?user_id=#{params[:payment][:user_id]}&rm=2"


    # @payment = Payment.new(payment_params)
    #
    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
    #     format.json { render :show, status: :created, location: @payment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:server_id, :user_id, :amount, :quantity, :payer_email, :description)
    end
end
