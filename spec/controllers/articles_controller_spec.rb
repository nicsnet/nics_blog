require 'spec_helper'

describe ArticlesController do

  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
  end

  let(:valid_attributes) { {title: 'title', content: 'content', user_id: user.id } }

  describe "GET index" do
    it "assigns all articles as @articles" do
      article = Article.create! valid_attributes
      get :index, {}
      assigns(:articles).should eq([article])
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes
      get :show, {id: article.to_param}
      assigns(:article).should eq(article)
    end
  end
  describe "GET new" do

    it "assigns a new article as @article" do
      get :new, {}
      assigns(:article).should be_a_new(Article)
    end
  end

  describe "GET edit" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes
      get :edit, {id: article.to_param}
      assigns(:article).should eq(article)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, {article: valid_attributes}
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {article: valid_attributes}
        assigns(:article).should be_a(Article)
        assigns(:article).should be_persisted
      end

      it "redirects to the articles index page" do
        post :create, {article: valid_attributes}
        response.should redirect_to('/articles')
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        Article.any_instance.stub(:errors).and_return(['error'])
        Article.any_instance.stub(:save).and_return(false)
        post :create, {article: {  }}
        assigns(:article).should be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        Article.any_instance.stub(:errors).and_return(['error'])
        Article.any_instance.stub(:save).and_return(false)
        post :create, {article: {  }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested article" do
        article = Article.create! valid_attributes
        Article.should_receive(:find).and_return(article)
        article.should_receive(:update_attributes).with({ 'title' => 'title', 'content' => 'content' })
        put :update, {id: article.to_param, article: { title: 'title', content: 'content' }}
      end

      it "assigns the requested article as @article" do
        article = Article.create! valid_attributes
        put :update, {id: article.to_param, article: valid_attributes}
        assigns(:article).should eq(article)
      end

      it "redirects to the article" do
        article = Article.create! valid_attributes
        put :update, {id: article.to_param, article: valid_attributes}
        response.should redirect_to(article)
      end
    end

    describe "with invalid params" do
      it "assigns the article as @article" do
        article = Article.create! valid_attributes
        Article.any_instance.stub(:errors).and_return(['error'])
        Article.any_instance.stub(:save).and_return(false)
        put :update, {id: article.to_param, article: {  }}
        assigns(:article).should eq(article)
      end

      it "re-renders the 'edit' template" do
        article = Article.create! valid_attributes
        Article.any_instance.stub(:errors).and_return(['error'])
        Article.any_instance.stub(:save).and_return(false)
        put :update, {id: article.to_param, article: {  }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested article" do
      article = Article.create! valid_attributes
      expect {
        delete :destroy, {id: article.to_param}
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      article = Article.create! valid_attributes
      delete :destroy, {id: article.to_param}
      response.should redirect_to(articles_url)
    end
  end
end
