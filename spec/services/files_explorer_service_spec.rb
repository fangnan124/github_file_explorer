require "rails_helper"

RSpec.describe FilesExplorerService do
  let(:service) { FilesExplorerService.new({
                                               repo_name: 'rails/rails',
                                               keyword: 'active',
                                               page: 1,
                                               per_page: 5
                                           }) }

  describe "#search" do
    before do
      @result = double("result")
      allow(@result).to receive(:total_count).and_return(100)
      allow_any_instance_of(Api::Github::Search).to receive(:search_code).and_return(@result)
      allow(service).to receive(:total_pages).and_return(20)
    end

    it "should return results" do
      expect(service.search).to eq(@result)
    end

    it "shoud set paginator" do
      service.search
      expect(service.paginator.limit_value).to eq(5)
      expect(service.paginator.total_pages).to eq(20)
      expect(service.paginator.current_page).to eq(1)
    end
  end

  describe "#repository_exist?" do
    context "when it is vaild" do
      it "should return true" do
        allow_any_instance_of(Api::Github::Search).to receive(:repository?).and_return(true)
        expect(service.repository_exist?).to eq(true)
      end
    end

    context "when it is not vaild" do
      it "should return true" do
        allow_any_instance_of(Api::Github::Search).to receive(:repository?).and_return(false)
        expect(service.repository_exist?).to eq(false)
      end
    end
  end

  describe "#total_pages" do
    context "when total count <= 1000" do
      it "should return calculated number" do
        response1 = service.send(:total_pages, 1000, 5)
        response2 = service.send(:total_pages, 0, 0)
        response3 = service.send(:total_pages, 5, 10)
        expect(response1).to eq(200)
        expect(response2).to eq(0)
        expect(response3).to eq(1)
      end
    end

    context "when total count > 1000" do
      it "should return calculated number equals to the case when it is 1000" do
        response = service.send(:total_pages, 1200, 5)
        expect(response).to eq(200)
      end
    end
  end

end
