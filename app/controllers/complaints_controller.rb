class ComplaintsController < ApplicationController
 
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]

  # GET /complaints
  # GET /complaints.json
  def index
    @complaints = Complaint.where(user:current_user);
  end

  # GET /complaints/1
  # GET /complaints/1.json
  def show
    @categories = Category.all  
  end

  # GET /complaints/new
  def new
    @complaint = Complaint.new
    @categories = Category.all
  end

  def abuse
    if simple_captcha_valid?
      ComplaintMailer.new_abuse(params[:url],params[:email],params[:text],params[:reason]).deliver_later
      respond_to do |format|
        flash[:success] = "Denúncia enviada. Verifique seu e-mail nos próximos dias!"
        format.html { redirect_to action: "show", id: params[:complaint_id]}  
      end
    else
      respond_to do |format|
       flash[:danger] = "Verificação invalida! Denúncia não realizada!"
       format.html { redirect_to action: "show", id: params[:complaint_id]} 
      end 
    end
  end

  def reply
    if simple_captcha_valid?
      ComplaintMailer.reply(params[:url],params[:email],params[:text],params[:name]).deliver_later
      respond_to do |format|
        flash[:success] = "Solicitação enviada. Verifique seu e-mail nos próximos dias!"
        format.html { redirect_to action: "show", id: params[:complaint_id]}  
      end
    else
      respond_to do |format|
       flash[:danger] = "Verificação invalida! Solicitação não realizada!"
       format.html { redirect_to action: "show", id: params[:complaint_id]} 
      end 
    end
  end

  # # GET /complaints/1/edit
  # def edit
  #   @categories = Category.all
  # end

  # POST /complaints
  # POST /complaints.json
  def create
    @categories = Category.all
    @complaint = Complaint.new(complaint_params)
    if user_signed_in?
      @complaint.user = current_user
    end
    respond_to do |format|
      if @complaint.save
        format.html { redirect_to action: "show", id: @complaint.id}
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  # def update
  #   respond_to do |format|
  #     if @complaint.update(complaint_params)
  #       format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @complaint }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @complaint.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /complaints/1
  # # DELETE /complaints/1.json
  # def destroy
  #   @complaint.destroy
  #   respond_to do |format|
  #     format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:latitude, :longitude, :body, :address, :title, :category_id, :user_id, :city)
    end
end
