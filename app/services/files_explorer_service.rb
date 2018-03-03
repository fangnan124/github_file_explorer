class FilesExplorerService
  attr_accessor :repo_name, :keyword, :page, :per_page, :paginator

  Paginator = Struct.new(:limit_value, :total_pages, :current_page)

  def initialize(attributes = {})
    self.repo_name = attributes[:repo_name]
    self.keyword = attributes[:keyword]
    self.page = attributes[:page]
    self.per_page = attributes[:per_page]
  end

  def search
    result = Api::Github::Search.new.search_code(
        {
            repo_name: repo_name,
            keyword: keyword,
            page: page,
            per_page: per_page
        }
    )
    self.paginator = Paginator.new(
        per_page.to_i,
        total_pages(result.total_count, per_page),
        page.to_i
    )
    result
  end

  def repository_exist?
    Api::Github::Search.new.repository?(repo_name)
  end

  private

  def total_pages(total_count, per_page)
    return 0 if per_page == 0
    total_count = 1000 if total_count > 1000
    remainder = total_count % per_page
    total_pages = (total_count - remainder)/per_page
    total_pages += 1 if remainder > 0
    total_pages
  end

end