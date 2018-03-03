module Api
  module Github
    class Search
      def search_code(params = {})
        options = {
            accept: "application/vnd.github.v3.text-match+json",
            page: params[:page],
            per_page: params[:per_page]
        }
        client.search_code("#{params[:keyword]} in:file repo:#{params[:repo_name]}", options)
      end

      def repository?(repo_name)
        client.repository?(repo_name)
      end

      private

      def client
        @_client ||= Octokit::Client.new
      end
    end
  end
end