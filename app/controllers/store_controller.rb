class StoreController < ApplicationController
  layout 'tabs'
  
  def index
    @page_title = "BSA Storefront"
  end
  
  def adaptive_redirect
    pay_request = PaypalAdaptive::Request.new

    data = {
    "returnUrl" => "http://brownbsa.com/storefront#thankyou", 
    "requestEnvelope" => {"errorLanguage" => "en_US"},
    "currencyCode"=>"USD",  
    "receiverList"=>{"receiver"=>[{"email"=>"scp_1331867183_biz@brown.edu", "amount"=>"100.00"}, {"email"=>"eandr_1331867066_biz@brown.edu", "amount"=>"695.00"}, {"email" => "ocm_1331866861_biz@brown.edu", "amount" => "129.98"}]},
    "cancelUrl"=>"http://brownbsa.com/store/checkout/cancel",
    "actionType"=>"PAY",
    "ipnNotificationUrl"=>"http://brownbsa.com/store/ipn_receive"
    }

    pay_response = pay_request.pay(data)

    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    else
      puts pay_response.errors.first['message']
      redirect_to failed_payment_url
    end
  end
  
  def checkout
    render :text => "OK"
  end
end
