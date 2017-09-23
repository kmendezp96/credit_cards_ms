class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:show, :update, :destroy]

  def renderError(message, code, description)
    render status: code,json: {
      message: message,
      code: code,
      description: description
    }
  end

  def index
    if(params[:firstResult])
      @first=params[:firstResult]
      if !(Integer( @first) rescue false)
        renderError("Not Acceptable (Invalid Params)", 406, "The parameter firstResult is not an integer")
        return -1
      end
      @first=params[:firstResult].to_f-1
      if(params[:maxResult])
          @max=params[:maxResult]
          if !(Integer( @max) rescue false)
            renderError("Not Acceptable (Invalid Params)", 406, "The parameter maxResult is not an integer")
            return -1
          end
          @credit_cards = CreditCard.all.limit(@max).offset(@first)
      else
        @credit_cards = CreditCard.all.offset(@first)
      end
    else
      if(params[:maxResult])
          @max=params[:maxResult]
          if !(Integer( @max) rescue false)
            renderError("Not Acceptable (Invalid Params)", 406, "The parameter maxResult is not an integer")
            return -1
          end
          @credit_cards = CreditCard.all.limit(@max)
      else
        @credit_cards = CreditCard.all
      end
    end
    render json: @credit_cards
  end

  # GET /credit_cards
  #def index
  #  @credit_cards = CreditCard.all

  #  render json: @credit_cards
  #end

  def show
    if !(Integer(params[:id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
      return -1
    end
    if(@credit_card)
      render json: @credit_card
    else
      renderError("Not Found", 404, "The resource does not exist")
    end
  end



  # GET /credit_cards/1
  #def show
  #  render json: @credit_card
  #end

  def create
    #if !(Integer(params[:number]) rescue false)
    #  renderError("Bad Request", 400, "The parameter number is not a Integer")
    #  return -1
    if !(Integer(params[:amount]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter amount is not an Integer")
      return -1
    elsif !(Integer(params[:expiration_month]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter expiration_month is not an Integer")
      return -1
    elsif !(Integer(params[:expiration_year]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter expiration_year is not an Integer")
    elsif !(Integer(params[:user_id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 400, "The parameter user_id is not an Integer")
      return -1
    else
      @credit_card = CreditCard.new(credit_card_params)
    end

    if @credit_card.save
      head 201
    else
      render json: @credit_card.errors, status: :unprocessable_entity
    end
  end
  # POST /credit_cards
  #def create
  #  @credit_card = CreditCard.new(credit_card_params)

  #  if @credit_card.save
  #    render json: @credit_card, status: :created, location: @credit_card
  #  else
  #    render json: @credit_card.errors, status: :unprocessable_entity
  #  end
  #end
  def update
    if !(Integer(params[:id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
      return -1
    end
    if(@credit_card)
      if (!params[:number]) && ( !params[:user_id])
        if @credit_card.update(credit_card_params)
          head 204
        else
          render json: @credit_card.errors, status: :unprocessable_entity
        end
      else
        renderResponse("Not acceptable",406,"Only expiration_month and expiration_year can be updated")
      end
    else
      renderError("Not Found", 404, "The resource does not exist")
      return -1
    end
    #if(params[:number])
    #  if !(Integer(params[:number]) rescue false)
    #    renderError("Bad Request", 406, "The parameter number is not a Float")
    #    return -1
    #  end
    #end
  end

  # PATCH/PUT /credit_cards/1
  #def update
  #  if @credit_card.update(credit_card_params)
  #    render json: @credit_card
  #  else
  #    render json: @credit_card.errors, status: :unprocessable_entity
  #  end
  #end

  def destroy
    if !(Integer(params[:id]) rescue false)
      renderError("Not Acceptable (Invalid Params)", 406, "The parameter id is not an integer")
      return -1
    end
    if(@credit_card)
      @credit_card.destroy
      head 200
    else
      renderError("Not Found", 404, "The resource does not exist")
    end
  end

  def user
    if(params[:q])
      user=params[:q]
      credit_card = CreditCard.credit_cards_by_user_id(user.to_i)
      render json: credit_card
    else
      render status: 400,json: {
        message: "User param(q) missing"
        }
    end
  end
  # DELETE /credit_cards/1
  #def destroy
  #  @credit_card.destroy
  #end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
      puts (@credit_card)
    end

    # Only allow a trusted parameter "white list" through.
    def credit_card_params
      params.require(:credit_card).permit(:number, :amount, :expiration_month, :expiration_year, :user_id)
    end
end
