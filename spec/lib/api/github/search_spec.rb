require "rails_helper"

RSpec.describe Api::Github::Search do
  let(:api) { Api::Github::Search.new }

  describe "#search_code" do
    let(:params) { { repo_name: "rails/rails",
                     keyword: "active",
                     page: 1,
                     per_page: 5 } }

    context "when valid" do
      it "should return success" do
        expect(api.search_code(params)).not_to be_nil
      end

      it "should not return error" do
        expect {
          api.search_code(params)
        }.not_to raise_error
      end
    end

    context "when not valid" do
      it "should raise Octokit::UnprocessableEntity error" do
        params[:repo_name] = "rails/rails9999"
        expect {
          api.search_code(params)
        }.to raise_error(Octokit::UnprocessableEntity)
      end

      it "should raise Octokit::UnprocessableEntity error" do
        params[:page] = 1000
        expect {
          api.search_code(params)
        }.to raise_error(Octokit::UnprocessableEntity)
      end
    end
  end

  describe "#repository?" do
    let(:repo_name) { "rails/rails" }

    context "when valid" do
      it "should return true" do
        expect(api.repository?(repo_name)).to eq(true)
      end

      it "should return success" do
        expect(api.repository?(repo_name)).not_to be_nil
      end

      it "should not return error" do
        expect {
          api.repository?(repo_name)
        }.not_to raise_error
      end
    end

    context "when not valid" do
      it "should raise Octokit::UnprocessableEntity error" do
        repo_name = "rails/rails9999"
        expect(api.repository?(repo_name)).to eq(false)
      end
    end
  end
end
