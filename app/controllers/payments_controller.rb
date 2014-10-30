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
    param = params.symbolize_keys

    Payment.create(
      server_id:    param[:item_name],
      user_id:      param[:user_id],
      amount:       param[:mc_gross],
      quantity:     param[:quantity],
      payer_email:  param[:payer_email],
      timestamp:    Time.now.to_i
    )

    redirect_to server_path(param[:item_name])
  end

  # POST /payments
  # POST /payments.json
  def create
    # https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business=alialhaulani-facilitator@ukr.net&item_name='+server_id+'&item_number=unrealm&amount='+price+'&quantity='+input+'&currency_code=USD&return=http://minecraftservers-ip.com/callback.php&rm=2
   redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business=alialhaulani-facilitator@ukr.net&item_name=#{params[:payment][:server_id]}&item_number=unrealm&amount=#{50}&quantity=#{params[:payment][:quantity]}&currency_code=USD&return=#{callback_url}?user_id=#{params[:payment][:user_id]}&rm=2"
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



# {"mc_gross"=>"50.00",
#  "protection_eligibility"=>"Eligible",
#  "address_status"=>"confirmed",
#  "payer_id"=>"RNUGAPSNULHV8",
#  "tax"=>"0.00",
#  "address_street"=>"1 Main St",
#  "payment_date"=>"06:53:29 Sep 11,
#  2014 PDT",
#  "payment_status"=>"Completed",
#  "charset"=>"windows-1252",
#  "address_zip"=>"95131",
#  "first_name"=>"Andrey",
#  "mc_fee"=>"1.75",
#  "address_country_code"=>"US",
#  "address_name"=>"Andrey Pristupa",
#  "notify_version"=>"3.8",
#  "custom"=>"",
#  "payer_status"=>"verified",
#  "business"=>"alialhaulani-facilitator@ukr.net",
#  "address_country"=>"United States",
#  "address_city"=>"San Jose",
#  "quantity"=>"1",
#  "payer_email"=>"kievcookie@gmail.com",
#  "verify_sign"=>"AFcWxV21C7fd0v3bYYYRCpSSRl31A4mAN5mBVg.0qcLCdStlRLquNApI",
#  "txn_id"=>"7K453181L6225501G",
#  "payment_type"=>"instant",
#  "last_name"=>"Pristupa",
#  "address_state"=>"CA",
#  "receiver_email"=>"alialhaulani-facilitator@ukr.net",
#  "payment_fee"=>"1.75",
#  "receiver_id"=>"W99ZQMBP58HRG",
#  "txn_type"=>"web_accept",
#  "item_name"=>"32",
#  "mc_currency"=>"USD",
#  "item_number"=>"unrealm",
#  "residence_country"=>"US",
#  "test_ipn"=>"1",
#  "handling_amount"=>"0.00",
#  "transaction_subject"=>"",
#  "payment_gross"=>"50.00",
#  "shipping"=>"0.00",
#  "merchant_return_link"=>"click here",
#  "auth"=>"AbyhZrY3g16hXqyAUHn6DFO5w.WVjK7Q9qv5byA64fq6k2hWwKCAr1JXx6DSFMZ-ouoXUSTJZy1Mc.7MBRFmAXA",
#  "user_id"=>"1"}
