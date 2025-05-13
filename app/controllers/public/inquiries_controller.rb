class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      InquiryMailer.inquiry_mail(@inquiry).deliver_now
      redirect_to done_public_inquiries_path
    else
      @inquiry = Inquiry.new
      render :new, status: :unprocessable_entity
    end
  end

  def done
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:email, :subject, :message)
  end
end
