require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do

  describe "#highlight_code" do
    it "should return highlighted code" do
      text = double("text")
      allow(text).to receive(:fragment).and_return("require 'active_support/testing/autorun' require 'active_support'")
      match1 = double("match1", text: "active", indices: [9, 15])
      match2 = double("match2", text: "active", indices: [50, 56])
      allow(text).to receive(:matches).and_return([ match1, match2 ])
      expect(helper.highlight_code(text)).to eq('<span>require &#39;</span>'\
      '<span class="highlight">active</span><span>_support/testing/autorun&#39; require &#39;</span>'\
      '<span class="highlight">active</span><span>_support&#39;</span>')
    end
  end

end