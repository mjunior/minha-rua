class ComplaintsController < ApplicationController
  before_action :find_complaint, only: [:show, :edit, :update, :destroy]

  # GET /complaints
  # GET /complaints.json
  def index
    if user_signed_in?
      @complaints = Complaint.where(user: current_user)
      @categories = Category.all
    else
      flash[:danger] = 'Efetue login para continuar'
      redirect_to new_user_session_path
    end
  end

  # GET /complaints/1
  # GET /complaints/1.json
  def show
    @categories = Category.all
    @allow_like = true
    @like_list = Interaction.where(complaint: @complaint).limit(5)
    @count_like = Interaction.where(complaint: @complaint).size - 5
    if user_signed_in?
      is_liked = !Interaction.where(['interaction_type_id = ? and complaint_id =
       ? and user_id = ?', 1, @complaint.id, current_user.id]).blank?
      @allow_like = !is_liked
    end
  end

  # GET /complaints/new
  def new
    if user_signed_in?
      @city = Cidade.friendly.find(params[:cidade])
      @complaint = Complaint.new
    else
      flash[:danger] = 'Para criar uma reclamação você deve
                        efetuar login ou criar uma conta'
      redirect_to new_user_session_path
    end
  end

  # Report abuse
  def abuse
    if simple_captcha_valid?
      ComplaintMailer.new_abuse(params[:url],
                                params[:email],
                                params[:text],
                                params[:reason]).deliver_later
      respond_to do |format|
        flash[:success] = 'Denúncia enviada. Verifique seu e-mail nos
        próximos dias!'
        format.html { redirect_to action: 'show', id: params[:complaint_id] }
      end
    else
      respond_to do |format|
        flash[:danger] = 'Verificação invalida! Denúncia não realizada!'
        format.html { redirect_to action: 'show', id: params[:complaint_id] }
      end
    end
  end

  # Request to reply
  def reply
    if simple_captcha_valid?
      ComplaintMailer.reply(params[:url], params[:email], params[:text],
                            params[:name]).deliver_later
      respond_to do |format|
        flash[:success] = 'Solicitação enviada. Verifique seu e-mail nos
        próximos dias!'
        format.html { redirect_to action: 'show',  id: params[:complaint_id] }
      end
    else
      respond_to do |format|
        flash[:danger] = 'Verificação invalida! Solicitação não realizada!'
        format.html { redirect_to action: 'show',  id: params[:complaint_id] }
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
      respond_to do |format|
        if @complaint.save
          begin
            ComplaintMailer.new_complaint(@complaint.slug,
                                          @complaint.user.email).deliver_later
            logger.debug 'EMAIL ENVIADO'
          rescue => ex
            logger.debug 'ERRO ENVIAR EMAIL'
            logger.debug ex.message
          end

          format.html { redirect_to action: 'show', id: @complaint.slug }
          format.json { render :show, status: :created, location: @complaint }
        else
          format.html { render :new }
          format.json { render json: @complaint.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # POST /complaint/:id/like
  def like
    if user_signed_in?
      complaint = Complaint.find(params[:complaint_id])
      type = InteractionType.find(1)

      if complaint && type
        interaction = Interaction.new
        interaction.interaction_type = type
        interaction.user = current_user
        interaction.complaint = complaint
        complaint.addInteraction(interaction)

        begin
          ComplaintMailer.like_complaint(current_user.first_name,
                                         complaint.slug,
                                         complaint.user.email).deliver_later
          logger.debug 'EMAIL ENVIADO'
        rescue => ex
          logger.debug 'ERRO ENVIAR EMAIL'
          logger.debug ex.message
        end

        render json: { status: 'success',
                       message: 'Like efetuado com sucesso!' }
      end
    else
      render json: { status: 'error', type: 'auth',
                     redirect_to: new_user_session_path }
    end
  end

  def liked
    @complaints = []
    if user_signed_in?
      interaction_list = Interaction.where(['interaction_type_id = ?
                                            and user_id = ?',
                                            1, current_user.id])
      interaction_list.each do |interaction|
        @complaints.push(interaction.complaint)
      end
    end
  end

# PATCH/PUT /complaints/1
# PATCH/PUT /complaints/1.json
# def update
#   respond_to do |format|
#     if @complaint.update(complaint_params)
#       format.html { redirect_to @complaint,  notice: 'Complaint was successfully updated.' }
#       format.json { render :show,  status: :ok,  location: @complaint }
#     else
#       format.html { render :edit }
#       format.json { render json: @complaint.errors,  status: :unprocessable_entity }
#     end
#   end
# end

# # DELETE /complaints/1
# # DELETE /complaints/1.json
# def destroy
#   @complaint.destroy
#   respond_to do |format|
#     format.html { redirect_to complaints_url,  notice: 'Complaint was successfully destroyed.' }
#     format.json { head :no_content }
#   end
# end

  private

    # Use callbacks to share common setup or constraints between actions.
    def find_complaint
      @complaint = Complaint.friendly.find(params[:id])
    end

    # Never trust parameters only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:image,
                                        :latitude,
                                        :longitude,
                                        :body,
                                        :address,
                                        :title,
                                        :category_id,
                                        :user_id,
                                        :cidade_id,
                                        :slug)
    end
end
