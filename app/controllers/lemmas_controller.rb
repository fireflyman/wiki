class LemmasController < ApplicationController
before_filter :load_lemma, :only => [:show, :edit, :update, :destroy]
  before_filter :new_lemma, :only => :new
 
  def index
    @lemmas = Lemma.all
  end
 
  def show;end
 
  def new;end
 
  def edit;end
   
  def create
    @lemma = Lemma.new params[:lemma]
    if @lemma.save
      #为词条的创建者添加积分。
      coauthor =  Coauthor.create!(:lemma => @lemma,:user => current_user,:activion => true)
      coauthor.user.increment!(:point,@lemma.point) if coauthor.active?
      flash[:notice] = '创建词条成功！'
      redirect_to @lemma
    else
      render :action => "new"
    end
  end
 
  def update
    if @lemma.update_attributes(params[:lemma])
      coauthor = Coauthor.find_by_user_id_and_lemma_id current_user.id,@lemma.id
      #只为后来的编辑者添加积分。
      #activation 为 true，表示在这词条上，该作者已被奖励过了！
      coauthor.user.increment!(:point,@lemma.point) unless coauthor.active?
      coauthor.update_attribute(:activion,true) unless coauthor.active?
      flash[:notice] = '更新词条成功！'
      redirect_to @lemma
    else
      render :action => "edit"
    end
  end
 
  def destroy
    @lemma.destroy
    flash[:notice] = '删除词条成功！'
    redirect_to lemmas_url
  end
 
  protected
  def load_lemma
    @lemma = Lemma.find(params[:id])
  end
 
  def new_lemma
    @lemma  = Lemma.new
  end
end
